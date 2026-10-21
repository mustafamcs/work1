/*
 * platform_win.cpp — platform/ katmaninin Windows uygulamasi.
 * Winsock2, CreateProcessW + Job Object (kill-on-close), UTF-16 dosya API.
 */
#include "../platform.h"

#ifndef _WIN32
#   error "platform_win.cpp sadece Windows'ta derlenir"
#endif

#ifndef WIN32_LEAN_AND_MEAN
#   define WIN32_LEAN_AND_MEAN
#endif
#include <winsock2.h>
#include <windows.h>

#include <cstdio>
#include <cstring>
#include <map>
#include <mutex>
#include <string>
#include <vector>

namespace
{

/* API'ler UTF-16; dis arayuz UTF-8. */
std::wstring Utf8ToWide(const char* s)
{
    if (!s || !*s)
        return std::wstring();
    const int len = MultiByteToWideChar(CP_UTF8, 0, s, -1, nullptr, 0);
    if (len <= 0)
        return std::wstring();
    std::wstring out(static_cast<size_t>(len) - 1, L'\0');
    MultiByteToWideChar(CP_UTF8, 0, s, -1, out.data(), len);
    return out;
}

std::string WideToUtf8(const wchar_t* w)
{
    if (!w || !*w)
        return std::string();
    const int len = WideCharToMultiByte(CP_UTF8, 0, w, -1, nullptr, 0,
                                        nullptr, nullptr);
    if (len <= 0)
        return std::string();
    std::string out(static_cast<size_t>(len) - 1, '\0');
    WideCharToMultiByte(CP_UTF8, 0, w, -1, out.data(), len, nullptr, nullptr);
    return out;
}

/* pid -> Job Object; handle acik kaldikca kill-on-close aktif */
std::mutex g_jobMutex;
std::map<PlatformPid, HANDLE> g_jobs;

void CloseJobLocked(PlatformPid pid)
{
    auto it = g_jobs.find(pid);
    if (it != g_jobs.end())
    {
        CloseHandle(it->second);
        g_jobs.erase(it);
    }
}

} // namespace

int PlatformInitSockets(void)
{
    WSADATA wsa{};
    return WSAStartup(MAKEWORD(2, 2), &wsa) == 0;
}

void PlatformShutdownSockets(void)
{
    WSACleanup();
}

PlatformPid PlatformSpawnProcess(const char* cwd, const char* exe,
                                 const char* const args[])
{
    if (!exe || !*exe)
        return 0;

    // komut satiri: "exe" "arg1" "arg2" ...
    std::wstring line = L'\"' + Utf8ToWide(exe) + L'\"';
    if (args)
    {
        for (const char* const* it = args; *it; ++it)
            line += L" \"" + Utf8ToWide(*it) + L'\"';
    }

    const std::wstring wcwd = Utf8ToWide(cwd);

    // CreateProcessW komut satirini yazilabilir bellek ister
    std::vector<wchar_t> buf(line.begin(), line.end());
    buf.push_back(L'\0');

    STARTUPINFOW si{};
    si.cb = sizeof(si);
    PROCESS_INFORMATION pi{};

    // CREATE_SUSPENDED: once Job'a ata, sonra ana thread'i baslat.
    // CREATE_NEW_PROCESS_GROUP: CTRL_BREAK nazik kapatabilsin diye.
    const DWORD flags = CREATE_SUSPENDED | CREATE_NEW_PROCESS_GROUP;
    if (!CreateProcessW(nullptr, buf.data(), nullptr, nullptr, FALSE,
                        flags, nullptr,
                        wcwd.empty() ? nullptr : wcwd.c_str(),
                        &si, &pi))
    {
        return 0;
    }

    // Job Object (kill-on-close): bu surec cikinca cocuk da oldurulur.
    HANDLE job = CreateJobObjectW(nullptr, nullptr);
    if (job)
    {
        JOBOBJECT_EXTENDED_LIMIT_INFORMATION info{};
        info.BasicLimitInformation.LimitFlags = JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE;
        if (SetInformationJobObject(job, JobObjectExtendedLimitInformation,
                                    &info, sizeof(info)) &&
            AssignProcessToJobObject(job, pi.hProcess))
        {
            std::lock_guard<std::mutex> lock(g_jobMutex);
            g_jobs[pi.dwProcessId] = job;
        }
        else
        {
            CloseHandle(job);
        }
    }

    ResumeThread(pi.hThread);
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
    return pi.dwProcessId;
}

int PlatformTerminateProcess(PlatformPid pid, unsigned gracefulMs)
{
    if (pid == 0)
        return 0;

    HANDLE h = OpenProcess(PROCESS_TERMINATE | SYNCHRONIZE |
                           PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
    if (!h)
        return 0;

    // once nazik: cocuk CREATE_NEW_PROCESS_GROUP ile acildiysa CTRL_BREAK
    // ayni konsolu paylasiyorsa teslim edilir; degilse sessizce basarisiz.
    (void)GenerateConsoleCtrlEvent(CTRL_BREAK_EVENT, pid);

    DWORD r = WaitForSingleObject(h, gracefulMs);
    if (r == WAIT_TIMEOUT)
    {
        if (TerminateProcess(h, 1))
            r = WaitForSingleObject(h, 5000);
    }
    const int stopped = (r == WAIT_OBJECT_0);
    CloseHandle(h);

    // Job kapaninca kill-on-close kalan cocuklari da temizler.
    {
        std::lock_guard<std::mutex> lock(g_jobMutex);
        CloseJobLocked(pid);
    }
    return stopped;
}

int PlatformIsProcessAlive(PlatformPid pid)
{
    if (pid == 0)
        return 0;

    int alive = 0;
    HANDLE h = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
    if (h)
    {
        DWORD code = 0;
        alive = (GetExitCodeProcess(h, &code) && code == STILL_ACTIVE) ? 1 : 0;
        CloseHandle(h);
    }
    if (!alive)
    {
        std::lock_guard<std::mutex> lock(g_jobMutex);
        CloseJobLocked(pid);
    }
    return alive;
}

int PlatformWritePidFile(const char* dir)
{
    wchar_t mod[MAX_PATH]{};
    if (GetModuleFileNameW(nullptr, mod, MAX_PATH) == 0)
        return 0;

    // <exe-stem>.pid — db.exe -> db.pid, game.exe -> game.pid
    std::wstring stem = mod;
    size_t pos = stem.find_last_of(L"\\/");
    stem = (pos == std::wstring::npos) ? stem : stem.substr(pos + 1);
    pos = stem.find_last_of(L'.');
    if (pos != std::wstring::npos)
        stem.erase(pos);

    std::wstring out = Utf8ToWide((dir && *dir) ? dir : ".");
    if (!out.empty() && out.back() != L'\\' && out.back() != L'/')
        out += L'\\';
    out += stem + L".pid";

    FILE* fp = nullptr;
    if (_wfopen_s(&fp, out.c_str(), L"w") != 0 || !fp)
        return 0;
    fprintf(fp, "%lu\n", GetCurrentProcessId());
    fclose(fp);
    return 1;
}

size_t PlatformPathJoin(char* out, size_t outSize,
                        const char* dir, const char* leaf)
{
    // UTF-8 giris -> UTF-16 birlestir -> UTF-8 cikis
    std::wstring w = Utf8ToWide(dir);
    while (!w.empty() && (w.back() == L'\\' || w.back() == L'/'))
        w.pop_back();
    const std::wstring l = Utf8ToWide(leaf);
    const std::wstring joined = w.empty() ? l : (l.empty() ? w : w + L'\\' + l);

    const std::string utf8 = WideToUtf8(joined.c_str());
    if (out && outSize)
    {
        const size_t n = (utf8.size() < outSize - 1) ? utf8.size() : outSize - 1;
        memcpy(out, utf8.data(), n);
        out[n] = '\0';
    }
    return utf8.size();
}

const char* PlatformExeSuffix(void)
{
    return ".exe";
}

const char* PlatformDefaultServiceName(void)
{
    return "metin2";
}
