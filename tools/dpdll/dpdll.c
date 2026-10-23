// dpdll.dll — work1 istemci koruma modulu (DaemonProtection)
// Istemci acilisinda LoadLibrary ile yuklenir; watchdog thread
// debugger ve bilinen hile araclarini izler, tespitte islemi kapatir.
#include <windows.h>
#include <tlhelp32.h>
#include <string.h>

#define WATCHDOG_INTERVAL_MS 1500

static HANDLE g_hWatchdog = NULL;
static volatile BOOL g_bRun = TRUE;

static int IsBadProcessName(const char* name)
{
    static const char* bad[] = {
        "cheatengine", "ollydbg", "x32dbg", "x64dbg", "windbg",
        "ida.exe", "ida64", "processhacker", "procmon", "procxp",
        "dnspy", "de4dot", "immunitydebugger", "scylla", "pin.exe",
        "frida", "ghidra", "radare", "cutter", "wpe", "injector",
        "speedhack", "m2bob", "lalaker", "switchbot", "hackshield_bypass"
    };
    char lower[260];
    size_t i;
    for (i = 0; name[i] && i < sizeof(lower) - 1; ++i)
        lower[i] = (char)tolower((unsigned char)name[i]);
    lower[i] = 0;
    for (i = 0; i < sizeof(bad) / sizeof(bad[0]); ++i)
        if (strstr(lower, bad[i]) != NULL)
            return 1;
    return 0;
}

static int ScanProcesses(void)
{
    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    PROCESSENTRY32 pe;
    int bad = 0;
    if (snap == INVALID_HANDLE_VALUE)
        return 0;
    pe.dwSize = sizeof(pe);
    if (Process32First(snap, &pe)) {
        DWORD self = GetCurrentProcessId();
        do {
            if (pe.th32ProcessID != self && IsBadProcessName(pe.szExeFile)) {
                bad = 1;
                break;
            }
        } while (Process32Next(snap, &pe));
    }
    CloseHandle(snap);
    return bad;
}

static DWORD WINAPI WatchdogProc(LPVOID param)
{
    BOOL remote = FALSE;
    (void)param;
    while (g_bRun) {
        if (IsDebuggerPresent())
            ExitProcess(0xDEAD);
        if (CheckRemoteDebuggerPresent(GetCurrentProcess(), &remote) && remote)
            ExitProcess(0xDEAD);
        if (ScanProcesses())
            ExitProcess(0xDEAD);
        Sleep(WATCHDOG_INTERVAL_MS);
    }
    return 0;
}

BOOL WINAPI DllMain(HINSTANCE hinst, DWORD reason, LPVOID reserved)
{
    (void)hinst; (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) {
        DisableThreadLibraryCalls(hinst);
        g_bRun = TRUE;
        g_hWatchdog = CreateThread(NULL, 0, WatchdogProc, NULL, 0, NULL);
    } else if (reason == DLL_PROCESS_DETACH) {
        g_bRun = FALSE;
        if (g_hWatchdog) {
            WaitForSingleObject(g_hWatchdog, WATCHDOG_INTERVAL_MS * 2);
            CloseHandle(g_hWatchdog);
            g_hWatchdog = NULL;
        }
    }
    return TRUE;
}
