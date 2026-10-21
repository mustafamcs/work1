#define WIN32_LEAN_AND_MEAN
#define NOMINMAX
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include <winsvc.h>
#include <shellapi.h>
#include <tlhelp32.h>
#include <iphlpapi.h>

#include <string>
#include <vector>

#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib, "ws2_32.lib")
#pragma comment(lib, "advapi32.lib")
#pragma comment(lib, "shell32.lib")

namespace {

constexpr UINT WM_APP_STATUS = WM_APP + 1;
constexpr UINT WM_APP_DONE = WM_APP + 2;

constexpr int IDC_LOG = 100;
constexpr int IDC_START = 101;
constexpr int IDC_STOP = 102;
constexpr int IDC_CLEAR = 103;

enum OwnedId {
	OWN_DB = 0,
	OWN_AUTH,
	OWN_CORE1,
	OWN_CH99,
	OWN_PHP,
	OWN_CLIENT,
	OWN_COUNT
};

const wchar_t* kNames[OWN_COUNT] = {
	L"db",
	L"auth",
	L"core1",
	L"channel99",
	L"panel",
	L"istemci"
};

const wchar_t* kExe[OWN_COUNT] = {
	L"C:\\Works\\work1\\server\\db\\db.exe",
	L"C:\\Works\\work1\\server\\auth\\game.exe",
	L"C:\\Works\\work1\\server\\channel1\\core1\\game.exe",
	L"C:\\Works\\work1\\server\\channel99\\game.exe",
	nullptr,
	L"C:\\Works\\work1\\client\\metin2client.exe"
};

const wchar_t* kDir[OWN_COUNT] = {
	L"C:\\Works\\work1\\server\\db",
	L"C:\\Works\\work1\\server\\auth",
	L"C:\\Works\\work1\\server\\channel1\\core1",
	L"C:\\Works\\work1\\server\\channel99",
	L"C:\\Works\\work1\\panel",
	L"C:\\Works\\work1\\client"
};

const unsigned short kPort[OWN_COUNT] = {
	30000,
	30001,
	30003,
	30901,
	8080,
	0
};

const bool kHide[OWN_COUNT] = {
	true,
	true,
	true,
	true,
	true,
	false
};

enum class RunMode {
	Gui,
	Stop,
	StartMaria
};

struct ProcRow {
	DWORD pid;
	DWORD parent;
};

struct ServiceInfo {
	std::wstring name;
	std::wstring binary;
	DWORD pid;
	DWORD state;
};

struct ElevateResult {
	bool launched;
	DWORD error;
	DWORD exitCode;
};

HWND g_hwnd = nullptr;
HWND g_log = nullptr;
HWND g_start = nullptr;
HWND g_stop = nullptr;
HWND g_clear = nullptr;
HFONT g_font = nullptr;
HINSTANCE g_inst = nullptr;
CRITICAL_SECTION g_cs;
HANDLE g_owned[OWN_COUNT] = {};
std::wstring g_maria = L"Haz\u0131r";
std::wstring g_line[OWN_COUNT];
bool g_busy = false;
bool g_viewReady = false;

bool FileExists(const std::wstring& path) {
	const DWORD attr = GetFileAttributesW(path.c_str());
	return attr != INVALID_FILE_ATTRIBUTES && (attr & FILE_ATTRIBUTE_DIRECTORY) == 0;
}

bool DirExists(const std::wstring& path) {
	const DWORD attr = GetFileAttributesW(path.c_str());
	return attr != INVALID_FILE_ATTRIBUTES && (attr & FILE_ATTRIBUTE_DIRECTORY) != 0;
}

std::wstring ToLower(std::wstring value) {
	for (wchar_t& ch : value) {
		if (ch >= L'A' && ch <= L'Z') {
			ch = static_cast<wchar_t>(ch - L'A' + L'a');
		}
	}
	return value;
}

bool IEquals(const std::wstring& left, const std::wstring& right) {
	return CompareStringW(LOCALE_INVARIANT, NORM_IGNORECASE, left.c_str(), -1, right.c_str(), -1) == CSTR_EQUAL;
}

bool EndsWithI(const std::wstring& value, const wchar_t* suffix) {
	const size_t n = wcslen(suffix);
	if (value.size() < n) {
		return false;
	}
	return IEquals(value.substr(value.size() - n), suffix);
}

bool IsPhpImage(const std::wstring& path) {
	return EndsWithI(path, L"\\php.exe");
}

bool IsMariaImage(const std::wstring& path) {
	const std::wstring lower = ToLower(path);
	return lower.find(L"mariadbd.exe") != std::wstring::npos || lower.find(L"mysqld.exe") != std::wstring::npos;
}

bool IsElevated() {
	HANDLE token = nullptr;
	if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token)) {
		return false;
	}
	TOKEN_ELEVATION elevation{};
	DWORD size = 0;
	const BOOL ok = GetTokenInformation(token, TokenElevation, &elevation, sizeof(elevation), &size);
	CloseHandle(token);
	return ok && elevation.TokenIsElevated;
}

std::wstring ExePath() {
	wchar_t path[MAX_PATH] = {};
	const DWORD n = GetModuleFileNameW(nullptr, path, MAX_PATH);
	if (n == 0 || n >= MAX_PATH) {
		return L"";
	}
	return path;
}

std::wstring StatusPath() {
	wchar_t temp[MAX_PATH] = {};
	const DWORD n = GetTempPathW(MAX_PATH, temp);
	if (n == 0 || n >= MAX_PATH) {
		return L"";
	}
	return std::wstring(temp) + L"Metin2Launcher-stop.txt";
}

std::wstring GetEnv(const wchar_t* name) {
	const DWORD n = GetEnvironmentVariableW(name, nullptr, 0);
	if (n == 0) {
		return L"";
	}
	std::wstring value(n, L'\0');
	const DWORD got = GetEnvironmentVariableW(name, &value[0], n);
	if (got == 0) {
		return L"";
	}
	value.resize(got);
	return value;
}

void AddPhpUnder(const std::wstring& root, std::vector<std::wstring>& out) {
	if (root.empty()) {
		return;
	}
	const std::wstring direct = root + L"\\php.exe";
	if (FileExists(direct)) {
		out.push_back(direct);
	}
	WIN32_FIND_DATAW data{};
	const HANDLE find = FindFirstFileW((root + L"\\*").c_str(), &data);
	if (find == INVALID_HANDLE_VALUE) {
		return;
	}
	do {
		if ((data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) == 0) {
			continue;
		}
		if (data.cFileName[0] == L'.') {
			continue;
		}
		const std::wstring candidate = root + L"\\" + data.cFileName + L"\\php.exe";
		if (FileExists(candidate)) {
			out.push_back(candidate);
		}
	} while (FindNextFileW(find, &data));
	FindClose(find);
}

void AddPhpFromPath(std::vector<std::wstring>& out) {
	const std::wstring path = GetEnv(L"PATH");
	size_t start = 0;
	while (start <= path.size()) {
		size_t semi = path.find(L';', start);
		if (semi == std::wstring::npos) {
			semi = path.size();
		}
		std::wstring dir = path.substr(start, semi - start);
		while (!dir.empty() && (dir.front() == L' ' || dir.front() == L'"')) {
			dir.erase(dir.begin());
		}
		while (!dir.empty() && (dir.back() == L' ' || dir.back() == L'"')) {
			dir.pop_back();
		}
		if (!dir.empty() && (dir.back() == L'\\' || dir.back() == L'/')) {
			dir.pop_back();
		}
		if (!dir.empty()) {
			const std::wstring candidate = dir + L"\\php.exe";
			if (FileExists(candidate)) {
				out.push_back(candidate);
			}
		}
		if (semi == path.size()) {
			break;
		}
		start = semi + 1;
	}
}

std::wstring FindPhp() {
	std::vector<std::wstring> found;
	AddPhpFromPath(found);
	if (!found.empty()) {
		return found.front();
	}

	const wchar_t* roots[] = {
		L"C:\\php",
		L"C:\\xampp\\php",
		L"C:\\Program Files\\php",
		L"C:\\Program Files (x86)\\php",
		L"C:\\Program Files\\PHP",
		L"C:\\tools\\php",
		L"C:\\laragon\\bin\\php",
		L"C:\\wamp64\\bin\\php",
		L"C:\\wamp\\bin\\php"
	};
	for (const wchar_t* root : roots) {
		AddPhpUnder(root, found);
	}

	const std::wstring local = GetEnv(L"LOCALAPPDATA");
	if (!local.empty()) {
		AddPhpUnder(local + L"\\Microsoft\\WinGet\\Packages", found);
	}
	const std::wstring programData = GetEnv(L"ProgramData");
	if (!programData.empty()) {
		AddPhpUnder(programData + L"\\chocolatey\\bin", found);
		AddPhpUnder(programData + L"\\chocolatey\\lib", found);
	}
	return found.empty() ? L"" : found.front();
}

unsigned short PortOf(DWORD value) {
	const unsigned short port = static_cast<unsigned short>(value & 0xFFFF);
	return static_cast<unsigned short>((port >> 8) | (port << 8));
}

void CollectPortPids4(unsigned short port, std::vector<DWORD>& pids) {
	DWORD size = 0;
	DWORD rc = GetExtendedTcpTable(nullptr, &size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_LISTENER, 0);
	if (rc != ERROR_INSUFFICIENT_BUFFER || size == 0) {
		return;
	}
	std::vector<unsigned char> buffer(size);
	rc = GetExtendedTcpTable(buffer.data(), &size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_LISTENER, 0);
	if (rc == ERROR_INSUFFICIENT_BUFFER) {
		buffer.resize(size);
		rc = GetExtendedTcpTable(buffer.data(), &size, FALSE, AF_INET, TCP_TABLE_OWNER_PID_LISTENER, 0);
	}
	if (rc != NO_ERROR) {
		return;
	}
	const auto* table = reinterpret_cast<const MIB_TCPTABLE_OWNER_PID*>(buffer.data());
	for (DWORD i = 0; i < table->dwNumEntries; ++i) {
		if (PortOf(table->table[i].dwLocalPort) == port && table->table[i].dwOwningPid != 0) {
			pids.push_back(table->table[i].dwOwningPid);
		}
	}
}

void CollectPortPids6(unsigned short port, std::vector<DWORD>& pids) {
	DWORD size = 0;
	DWORD rc = GetExtendedTcpTable(nullptr, &size, FALSE, AF_INET6, TCP_TABLE_OWNER_PID_LISTENER, 0);
	if (rc != ERROR_INSUFFICIENT_BUFFER || size == 0) {
		return;
	}
	std::vector<unsigned char> buffer(size);
	rc = GetExtendedTcpTable(buffer.data(), &size, FALSE, AF_INET6, TCP_TABLE_OWNER_PID_LISTENER, 0);
	if (rc == ERROR_INSUFFICIENT_BUFFER) {
		buffer.resize(size);
		rc = GetExtendedTcpTable(buffer.data(), &size, FALSE, AF_INET6, TCP_TABLE_OWNER_PID_LISTENER, 0);
	}
	if (rc != NO_ERROR) {
		return;
	}
	const auto* table = reinterpret_cast<const MIB_TCP6TABLE_OWNER_PID*>(buffer.data());
	for (DWORD i = 0; i < table->dwNumEntries; ++i) {
		if (PortOf(table->table[i].dwLocalPort) == port && table->table[i].dwOwningPid != 0) {
			pids.push_back(table->table[i].dwOwningPid);
		}
	}
}

std::vector<DWORD> PidsForPort(unsigned short port) {
	std::vector<DWORD> pids;
	if (port == 0) {
		return pids;
	}
	CollectPortPids4(port, pids);
	CollectPortPids6(port, pids);
	return pids;
}

bool IsPortListening(unsigned short port) {
	return !PidsForPort(port).empty();
}

bool WaitForPort(unsigned short port, DWORD timeoutMs, bool wantOpen) {
	const ULONGLONG start = GetTickCount64();
	while (GetTickCount64() - start < timeoutMs) {
		if (IsPortListening(port) == wantOpen) {
			return true;
		}
		Sleep(200);
	}
	return IsPortListening(port) == wantOpen;
}

std::wstring ImagePath(DWORD pid) {
	HANDLE process = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
	if (!process) {
		return L"";
	}
	wchar_t path[32768] = {};
	DWORD size = 32768;
	std::wstring result;
	if (QueryFullProcessImageNameW(process, 0, path, &size)) {
		result.assign(path, size);
	}
	CloseHandle(process);
	return result;
}

std::vector<ProcRow> SnapshotProcesses() {
	std::vector<ProcRow> rows;
	const HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	if (snap == INVALID_HANDLE_VALUE) {
		return rows;
	}
	PROCESSENTRY32W entry{};
	entry.dwSize = sizeof(entry);
	if (Process32FirstW(snap, &entry)) {
		do {
			ProcRow row{};
			row.pid = entry.th32ProcessID;
			row.parent = entry.th32ParentProcessID;
			rows.push_back(row);
		} while (Process32NextW(snap, &entry));
	}
	CloseHandle(snap);
	return rows;
}

bool ContainsPid(const std::vector<DWORD>& pids, DWORD pid) {
	for (DWORD item : pids) {
		if (item == pid) {
			return true;
		}
	}
	return false;
}

std::vector<DWORD> PidsByImage(const std::wstring& fullPath) {
	std::vector<DWORD> pids;
	if (fullPath.empty()) {
		return pids;
	}
	for (const ProcRow& row : SnapshotProcesses()) {
		if (row.pid == 0) {
			continue;
		}
		if (IEquals(ImagePath(row.pid), fullPath)) {
			pids.push_back(row.pid);
		}
	}
	return pids;
}

void AddPhpChildren(DWORD root, std::vector<DWORD>& pids) {
	const std::vector<ProcRow> rows = SnapshotProcesses();
	bool grew = true;
	for (int depth = 0; depth < 4 && grew; ++depth) {
		grew = false;
		for (const ProcRow& row : rows) {
			if (row.parent != root && !ContainsPid(pids, row.parent)) {
				continue;
			}
			if (row.parent != root && row.parent != 0 && !ContainsPid(pids, row.parent)) {
				continue;
			}
			if (!ContainsPid(pids, row.pid) && IsPhpImage(ImagePath(row.pid))) {
				bool parentOk = row.parent == root || ContainsPid(pids, row.parent);
				if (parentOk) {
					pids.push_back(row.pid);
					grew = true;
				}
			}
		}
	}
}

void Publish() {
	if (g_hwnd) {
		PostMessageW(g_hwnd, WM_APP_STATUS, 0, 0);
	}
}

void SetMaria(const std::wstring& text) {
	EnterCriticalSection(&g_cs);
	g_maria = text;
	g_viewReady = true;
	LeaveCriticalSection(&g_cs);
	Publish();
}

void SetLine(int index, const std::wstring& text) {
	EnterCriticalSection(&g_cs);
	g_line[index] = text;
	g_viewReady = true;
	LeaveCriticalSection(&g_cs);
	Publish();
}

std::wstring BuildText() {
	std::wstring text;
	EnterCriticalSection(&g_cs);
	text = g_maria;
	text += L"\r\n";
	for (int i = 0; i < OWN_COUNT; ++i) {
		text += kNames[i];
		text += L": ";
		text += g_line[i].empty() ? L"..." : g_line[i];
		text += L"\r\n";
	}
	LeaveCriticalSection(&g_cs);
	return text;
}

void WriteStatus() {
	const std::wstring path = StatusPath();
	if (path.empty()) {
		return;
	}
	std::wstring maria;
	std::wstring lines[OWN_COUNT];
	EnterCriticalSection(&g_cs);
	maria = g_maria;
	for (int i = 0; i < OWN_COUNT; ++i) {
		lines[i] = g_line[i];
	}
	LeaveCriticalSection(&g_cs);

	std::wstring body = L"elevated=1\nmaria=";
	body += maria;
	body += L"\n";
	for (int i = 0; i < OWN_COUNT; ++i) {
		body += std::to_wstring(i);
		body += L"=";
		body += lines[i];
		body += L"\n";
	}

	const HANDLE file = CreateFileW(path.c_str(), GENERIC_WRITE, FILE_SHARE_READ, nullptr, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, nullptr);
	if (file == INVALID_HANDLE_VALUE) {
		return;
	}
	const WORD bom = 0xFEFF;
	DWORD written = 0;
	WriteFile(file, &bom, sizeof(bom), &written, nullptr);
	WriteFile(file, body.data(), static_cast<DWORD>(body.size() * sizeof(wchar_t)), &written, nullptr);
	CloseHandle(file);
}

bool LoadStatus() {
	const std::wstring path = StatusPath();
	if (path.empty()) {
		return false;
	}
	const HANDLE file = CreateFileW(path.c_str(), GENERIC_READ, FILE_SHARE_READ, nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
	if (file == INVALID_HANDLE_VALUE) {
		return false;
	}
	const DWORD size = GetFileSize(file, nullptr);
	if (size == INVALID_FILE_SIZE || size < sizeof(wchar_t) || size > 1024 * 1024) {
		CloseHandle(file);
		return false;
	}
	std::vector<unsigned char> buffer(size);
	DWORD read = 0;
	const BOOL ok = ReadFile(file, buffer.data(), size, &read, nullptr);
	CloseHandle(file);
	if (!ok || read < sizeof(wchar_t)) {
		return false;
	}
	size_t offset = 0;
	if (read >= 2 && buffer[0] == 0xFF && buffer[1] == 0xFE) {
		offset = 2;
	}
	if (((read - offset) % sizeof(wchar_t)) != 0) {
		return false;
	}
	std::wstring text(reinterpret_cast<const wchar_t*>(buffer.data() + offset), (read - offset) / sizeof(wchar_t));
	bool any = false;
	size_t start = 0;
	while (start < text.size()) {
		size_t end = text.find(L'\n', start);
		if (end == std::wstring::npos) {
			end = text.size();
		}
		std::wstring line = text.substr(start, end - start);
		if (!line.empty() && line.back() == L'\r') {
			line.pop_back();
		}
		const size_t eq = line.find(L'=');
		if (eq != std::wstring::npos) {
			const std::wstring key = line.substr(0, eq);
			const std::wstring value = line.substr(eq + 1);
			if (key == L"maria") {
				SetMaria(value);
				any = true;
			} else if (key.size() == 1 && key[0] >= L'0' && key[0] < L'0' + OWN_COUNT) {
				SetLine(key[0] - L'0', value);
				any = true;
			}
		}
		start = end + 1;
	}
	return any;
}

bool IsAlive(HANDLE process) {
	if (!process) {
		return false;
	}
	DWORD code = 0;
	if (!GetExitCodeProcess(process, &code)) {
		return false;
	}
	return code == STILL_ACTIVE;
}

bool IsMariaProcess(HANDLE process) {
	wchar_t path[MAX_PATH] = {};
	DWORD size = MAX_PATH;
	if (!QueryFullProcessImageNameW(process, 0, path, &size)) {
		return false;
	}
	return IsMariaImage(path);
}

void ReleaseOwned(int index) {
	if (g_owned[index]) {
		CloseHandle(g_owned[index]);
		g_owned[index] = nullptr;
	}
}

RunMode ParseRunMode() {
	int argc = 0;
	LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);
	RunMode mode = RunMode::Gui;
	if (!argv) {
		return mode;
	}
	for (int i = 1; i < argc; ++i) {
		if (IEquals(argv[i], L"--start-maria")) {
			mode = RunMode::StartMaria;
		} else if (IEquals(argv[i], L"--stop")) {
			mode = RunMode::Stop;
		}
	}
	LocalFree(argv);
	return mode;
}

ElevateResult ElevateAndWait(const wchar_t* parameters) {
	ElevateResult result{};
	const std::wstring path = ExePath();
	if (path.empty()) {
		result.error = ERROR_FILE_NOT_FOUND;
		return result;
	}

	SHELLEXECUTEINFOW info{};
	info.cbSize = sizeof(info);
	info.fMask = SEE_MASK_NOCLOSEPROCESS;
	info.hwnd = g_hwnd;
	info.lpVerb = L"runas";
	info.lpFile = path.c_str();
	info.lpParameters = parameters;
	info.nShow = SW_HIDE;
	if (!ShellExecuteExW(&info)) {
		result.error = GetLastError();
		return result;
	}

	result.launched = true;
	result.exitCode = 1;
	if (info.hProcess) {
		WaitForSingleObject(info.hProcess, INFINITE);
		GetExitCodeProcess(info.hProcess, &result.exitCode);
		CloseHandle(info.hProcess);
	}
	return result;
}

bool QueryServiceBinary(SC_HANDLE scm, const wchar_t* name, std::wstring& binary) {
	const SC_HANDLE service = OpenServiceW(scm, name, SERVICE_QUERY_CONFIG);
	if (!service) {
		return false;
	}
	DWORD needed = 0;
	QueryServiceConfigW(service, nullptr, 0, &needed);
	if (needed == 0) {
		CloseServiceHandle(service);
		return false;
	}
	std::vector<unsigned char> buffer(needed);
	if (!QueryServiceConfigW(service, reinterpret_cast<QUERY_SERVICE_CONFIGW*>(buffer.data()), needed, &needed)) {
		CloseServiceHandle(service);
		return false;
	}
	const auto* config = reinterpret_cast<QUERY_SERVICE_CONFIGW*>(buffer.data());
	if (config->lpBinaryPathName) {
		binary = config->lpBinaryPathName;
	}
	CloseServiceHandle(service);
	return !binary.empty();
}

bool EnumServices(std::vector<ServiceInfo>& out) {
	const SC_HANDLE scm = OpenSCManagerW(nullptr, nullptr, SC_MANAGER_ENUMERATE_SERVICE);
	if (!scm) {
		return false;
	}
	DWORD needed = 0;
	DWORD count = 0;
	DWORD resume = 0;
	EnumServicesStatusExW(scm, SC_ENUM_PROCESS_INFO, SERVICE_WIN32, SERVICE_STATE_ALL, nullptr, 0, &needed, &count, &resume, nullptr);
	if (needed == 0) {
		CloseServiceHandle(scm);
		return false;
	}
	std::vector<unsigned char> buffer(needed);
	resume = 0;
	if (!EnumServicesStatusExW(scm, SC_ENUM_PROCESS_INFO, SERVICE_WIN32, SERVICE_STATE_ALL, buffer.data(), static_cast<DWORD>(buffer.size()), &needed, &count, &resume, nullptr)) {
		if (GetLastError() != ERROR_MORE_DATA || needed == 0) {
			CloseServiceHandle(scm);
			return false;
		}
		buffer.resize(needed);
		resume = 0;
		if (!EnumServicesStatusExW(scm, SC_ENUM_PROCESS_INFO, SERVICE_WIN32, SERVICE_STATE_ALL, buffer.data(), static_cast<DWORD>(buffer.size()), &needed, &count, &resume, nullptr)) {
			CloseServiceHandle(scm);
			return false;
		}
	}

	const auto* entries = reinterpret_cast<ENUM_SERVICE_STATUS_PROCESSW*>(buffer.data());
	out.reserve(count);
	for (DWORD i = 0; i < count; ++i) {
		ServiceInfo info{};
		info.name = entries[i].lpServiceName ? entries[i].lpServiceName : L"";
		info.pid = entries[i].ServiceStatusProcess.dwProcessId;
		info.state = entries[i].ServiceStatusProcess.dwCurrentState;
		QueryServiceBinary(scm, info.name.c_str(), info.binary);
		out.push_back(info);
	}
	CloseServiceHandle(scm);
	return true;
}

bool FindMariaService(ServiceInfo& out) {
	std::vector<ServiceInfo> services;
	if (!EnumServices(services)) {
		return false;
	}
	DWORD listener = 0;
	const std::vector<DWORD> listeners = PidsForPort(3306);
	if (!listeners.empty()) {
		listener = listeners.front();
	}

	const ServiceInfo* best = nullptr;
	int bestScore = -1;
	for (const ServiceInfo& service : services) {
		const bool binaryMatch = IsMariaImage(service.binary);
		const bool nameMatch = IEquals(service.name, L"MariaDB") || IEquals(service.name, L"MySQL");
		const bool pidMatch = listener != 0 && service.pid == listener;
		if (!binaryMatch && !nameMatch && !pidMatch) {
			continue;
		}
		int score = 0;
		if (binaryMatch) {
			score += 4;
		}
		if (nameMatch) {
			score += 2;
		}
		if (pidMatch) {
			score += 8;
		}
		if (score > bestScore) {
			bestScore = score;
			best = &service;
		}
	}
	if (!best) {
		return false;
	}
	out = *best;
	return true;
}

bool FindServiceByPid(DWORD pid, ServiceInfo& out) {
	if (pid == 0) {
		return false;
	}
	std::vector<ServiceInfo> services;
	if (!EnumServices(services)) {
		return false;
	}
	for (const ServiceInfo& service : services) {
		if (service.pid == pid) {
			out = service;
			return true;
		}
	}
	return false;
}

bool WaitServiceState(SC_HANDLE service, DWORD wanted, DWORD timeoutMs) {
	const ULONGLONG start = GetTickCount64();
	while (GetTickCount64() - start < timeoutMs) {
		SERVICE_STATUS_PROCESS status{};
		DWORD needed = 0;
		if (!QueryServiceStatusEx(service, SC_STATUS_PROCESS_INFO, reinterpret_cast<LPBYTE>(&status), sizeof(status), &needed)) {
			return false;
		}
		if (status.dwCurrentState == wanted) {
			return true;
		}
		if (wanted == SERVICE_RUNNING && status.dwCurrentState == SERVICE_STOPPED) {
			return false;
		}
		Sleep(200);
	}
	SERVICE_STATUS_PROCESS status{};
	DWORD needed = 0;
	if (!QueryServiceStatusEx(service, SC_STATUS_PROCESS_INFO, reinterpret_cast<LPBYTE>(&status), sizeof(status), &needed)) {
		return false;
	}
	return status.dwCurrentState == wanted;
}

bool StartMariaService(const std::wstring& name, DWORD& error) {
	error = 0;
	const SC_HANDLE scm = OpenSCManagerW(nullptr, nullptr, SC_MANAGER_CONNECT);
	if (!scm) {
		error = GetLastError();
		return false;
	}
	const SC_HANDLE service = OpenServiceW(scm, name.c_str(), SERVICE_START | SERVICE_QUERY_STATUS);
	if (!service) {
		error = GetLastError();
		CloseServiceHandle(scm);
		return false;
	}

	SERVICE_STATUS_PROCESS status{};
	DWORD needed = 0;
	if (QueryServiceStatusEx(service, SC_STATUS_PROCESS_INFO, reinterpret_cast<LPBYTE>(&status), sizeof(status), &needed)) {
		if (status.dwCurrentState == SERVICE_STOP_PENDING) {
			WaitServiceState(service, SERVICE_STOPPED, 20000);
		}
	}

	if (!StartServiceW(service, 0, nullptr)) {
		error = GetLastError();
		if (error != ERROR_SERVICE_ALREADY_RUNNING) {
			CloseServiceHandle(service);
			CloseServiceHandle(scm);
			return false;
		}
	}

	const bool running = WaitServiceState(service, SERVICE_RUNNING, 45000);
	CloseServiceHandle(service);
	CloseServiceHandle(scm);
	if (!running && !IsPortListening(3306)) {
		if (error == 0) {
			error = ERROR_SERVICE_REQUEST_TIMEOUT;
		}
		return false;
	}
	return WaitForPort(3306, 45000, true);
}

bool ControlStopService(const std::wstring& name, DWORD& error) {
	error = 0;
	const SC_HANDLE scm = OpenSCManagerW(nullptr, nullptr, SC_MANAGER_CONNECT);
	if (!scm) {
		error = GetLastError();
		return false;
	}
	const SC_HANDLE service = OpenServiceW(scm, name.c_str(), SERVICE_STOP | SERVICE_QUERY_STATUS);
	if (!service) {
		error = GetLastError();
		CloseServiceHandle(scm);
		return false;
	}

	SERVICE_STATUS status{};
	if (!ControlService(service, SERVICE_CONTROL_STOP, &status)) {
		error = GetLastError();
		if (error != ERROR_SERVICE_NOT_ACTIVE && error != ERROR_SERVICE_CANNOT_ACCEPT_CTRL) {
			CloseServiceHandle(service);
			CloseServiceHandle(scm);
			return false;
		}
	}
	const bool stopped = WaitServiceState(service, SERVICE_STOPPED, 30000);
	CloseServiceHandle(service);
	CloseServiceHandle(scm);
	if (!stopped && error == 0) {
		error = ERROR_SERVICE_REQUEST_TIMEOUT;
	}
	return stopped;
}

bool StopPid(DWORD pid, DWORD& error) {
	error = 0;
	if (pid == 0 || pid == GetCurrentProcessId()) {
		error = ERROR_INVALID_PARAMETER;
		return false;
	}
	const HANDLE process = OpenProcess(PROCESS_TERMINATE | SYNCHRONIZE | PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
	if (!process) {
		error = GetLastError();
		return error == ERROR_INVALID_PARAMETER;
	}
	if (!TerminateProcess(process, 0)) {
		error = GetLastError();
		DWORD code = 0;
		if (GetExitCodeProcess(process, &code) && code != STILL_ACTIVE) {
			CloseHandle(process);
			error = 0;
			return true;
		}
		CloseHandle(process);
		return false;
	}
	WaitForSingleObject(process, 8000);
	CloseHandle(process);
	return true;
}

void LaunchOne(int index, const std::wstring& exe, const std::wstring& args) {
	if (IsAlive(g_owned[index])) {
		SetLine(index, L"\u00E7al\u0131\u015F\u0131yor");
		return;
	}
	ReleaseOwned(index);

	if (kPort[index] != 0 && IsPortListening(kPort[index])) {
		SetLine(index, L"\u00E7al\u0131\u015F\u0131yor");
		return;
	}

	if (exe.empty() || !FileExists(exe)) {
		SetLine(index, index == OWN_PHP ? L"hata (php bulunamad\u0131)" : L"hata (dosya yok)");
		return;
	}
	if (!DirExists(kDir[index])) {
		SetLine(index, L"hata (klas\u00F6r yok)");
		return;
	}

	std::wstring command = L"\"" + exe + L"\"";
	if (!args.empty()) {
		command += L" ";
		command += args;
	}
	std::vector<wchar_t> commandBuffer(command.begin(), command.end());
	commandBuffer.push_back(L'\0');

	STARTUPINFOW startup{};
	startup.cb = sizeof(startup);
	startup.dwFlags = STARTF_USESHOWWINDOW;
	startup.wShowWindow = kHide[index] ? SW_HIDE : SW_SHOWNORMAL;

	DWORD flags = CREATE_NEW_PROCESS_GROUP;
	if (kHide[index]) {
		flags |= CREATE_NO_WINDOW;
	}

	PROCESS_INFORMATION info{};
	const BOOL ok = CreateProcessW(
		exe.c_str(),
		commandBuffer.data(),
		nullptr,
		nullptr,
		FALSE,
		flags,
		nullptr,
		kDir[index],
		&startup,
		&info);
	if (!ok) {
		SetLine(index, L"hata (" + std::to_wstring(GetLastError()) + L")");
		return;
	}

	CloseHandle(info.hThread);
	g_owned[index] = info.hProcess;
	SetLine(index, L"\u00E7al\u0131\u015F\u0131yor");
}

bool WaitIndexDown(int index, DWORD timeoutMs) {
	const ULONGLONG start = GetTickCount64();
	while (GetTickCount64() - start < timeoutMs) {
		bool portUp = false;
		if (kPort[index] != 0) {
			if (index == OWN_PHP) {
				for (DWORD pid : PidsForPort(kPort[index])) {
					if (IsPhpImage(ImagePath(pid))) {
						portUp = true;
						break;
					}
				}
			} else {
				portUp = IsPortListening(kPort[index]);
			}
		}
		bool imageUp = false;
		if (kExe[index]) {
			imageUp = !PidsByImage(kExe[index]).empty();
		}
		if (!portUp && !imageUp) {
			return true;
		}
		Sleep(200);
	}
	return false;
}

bool StopIndex(int index) {
	if (g_owned[index] && IsMariaProcess(g_owned[index])) {
		SetLine(index, L"hata");
		return false;
	}

	const bool hadOwned = IsAlive(g_owned[index]);
	if (hadOwned) {
		DWORD ignored = 0;
		TerminateProcess(g_owned[index], 0);
		WaitForSingleObject(g_owned[index], 8000);
	}
	ReleaseOwned(index);

	std::vector<DWORD> pids;
	bool wasUp = hadOwned;
	if (index == OWN_PHP) {
		for (DWORD pid : PidsForPort(8080)) {
			if (IsPhpImage(ImagePath(pid))) {
				pids.push_back(pid);
				wasUp = true;
			}
		}
		std::vector<DWORD> roots = pids;
		for (DWORD root : roots) {
			AddPhpChildren(root, pids);
		}
	} else if (kExe[index]) {
		pids = PidsByImage(kExe[index]);
		if (!pids.empty()) {
			wasUp = true;
		}
		if (kPort[index] != 0 && IsPortListening(kPort[index])) {
			wasUp = true;
			for (DWORD pid : PidsForPort(kPort[index])) {
				const std::wstring image = ImagePath(pid);
				if (IsMariaImage(image)) {
					continue;
				}
				if (IEquals(image, kExe[index]) && !ContainsPid(pids, pid)) {
					pids.push_back(pid);
				}
			}
		}
	}

	bool failed = false;
	for (DWORD pid : pids) {
		const std::wstring image = ImagePath(pid);
		if (IsMariaImage(image)) {
			continue;
		}
		DWORD error = 0;
		if (StopPid(pid, error)) {
			continue;
		}
		ServiceInfo service{};
		DWORD stopError = 0;
		if (FindServiceByPid(pid, service) && ControlStopService(service.name, stopError)) {
			continue;
		}
		failed = true;
	}

	const bool gone = WaitIndexDown(index, 12000);
	if (!gone || failed) {
		if (!gone) {
			SetLine(index, L"hata");
			return false;
		}
	}
	SetLine(index, wasUp ? L"durduruldu" : L"kapal\u0131");
	return true;
}

bool StopMaria() {
	ServiceInfo service{};
	const bool hasService = FindMariaService(service);
	const bool listening = IsPortListening(3306);
	if (!listening && (!hasService || service.pid == 0 || service.state == SERVICE_STOPPED)) {
		SetMaria(L"MariaDB: kapal\u0131");
		return true;
	}

	DWORD listener = 0;
	const std::vector<DWORD> listeners = PidsForPort(3306);
	if (!listeners.empty()) {
		listener = listeners.front();
	} else if (hasService) {
		listener = service.pid;
	}

	DWORD error = 0;
	if (listener != 0) {
		StopPid(listener, error);
	}
	bool still = IsPortListening(3306);
	const bool serviceStillUp = hasService && service.pid != 0 && service.state != SERVICE_STOPPED;
	if (hasService && (still || serviceStillUp || error == ERROR_ACCESS_DENIED)) {
		DWORD stopError = 0;
		if (!ControlStopService(service.name, stopError) && (IsPortListening(3306) || stopError != ERROR_SERVICE_NOT_ACTIVE)) {
			if (IsPortListening(3306)) {
				SetMaria(L"MariaDB: hata (" + std::to_wstring(stopError ? stopError : error) + L")");
				return false;
			}
		}
	} else if (!hasService && still) {
		SetMaria(L"MariaDB: hata (" + std::to_wstring(error) + L")");
		return false;
	}

	if (!WaitForPort(3306, 20000, false)) {
		SetMaria(L"MariaDB: hata");
		return false;
	}
	SetMaria(L"MariaDB: durduruldu");
	return true;
}

int PerformStop() {
	const int order[OWN_COUNT] = {
		OWN_CLIENT,
		OWN_PHP,
		OWN_CH99,
		OWN_CORE1,
		OWN_AUTH,
		OWN_DB
	};
	for (int index : order) {
		if (!StopIndex(index) && index == OWN_DB) {
			SetMaria(L"MariaDB: db kapanmadan durdurulmad\u0131");
			WriteStatus();
			return 1;
		}
	}
	const bool mariaOk = StopMaria();
	WriteStatus();
	if (!mariaOk || IsPortListening(3306)) {
		return 1;
	}
	for (int index : order) {
		if (kPort[index] != 0 && index != OWN_PHP && IsPortListening(kPort[index])) {
			return 1;
		}
		if (index == OWN_PHP) {
			for (DWORD pid : PidsForPort(8080)) {
				if (IsPhpImage(ImagePath(pid))) {
					return 1;
				}
			}
		}
		if (index == OWN_CLIENT && kExe[index] && !PidsByImage(kExe[index]).empty()) {
			return 1;
		}
	}
	return 0;
}

bool EnsureMaria() {
	if (IsPortListening(3306)) {
		SetMaria(L"MariaDB: \u00E7al\u0131\u015F\u0131yor");
		return true;
	}

	ServiceInfo service{};
	if (!FindMariaService(service)) {
		SetMaria(L"MariaDB kapal\u0131");
		return false;
	}

	DWORD error = 0;
	if (StartMariaService(service.name, error)) {
		SetMaria(L"MariaDB: \u00E7al\u0131\u015F\u0131yor");
		return true;
	}

	if (error == ERROR_ACCESS_DENIED && !IsElevated()) {
		const ElevateResult elevated = ElevateAndWait(L"--start-maria");
		if (!elevated.launched) {
			if (elevated.error == ERROR_CANCELLED) {
				SetMaria(L"MariaDB: iptal (UAC onaylanmad\u0131)");
			} else {
				SetMaria(L"MariaDB: hata (" + std::to_wstring(elevated.error) + L")");
			}
			return false;
		}
		if (WaitForPort(3306, 45000, true)) {
			SetMaria(L"MariaDB: \u00E7al\u0131\u015F\u0131yor");
			return true;
		}
		SetMaria(L"MariaDB: hata");
		return false;
	}

	SetMaria(L"MariaDB: hata (" + std::to_wstring(error) + L")");
	return false;
}

void WatchOwned() {
	for (int n = 0; n < 20; ++n) {
		Sleep(250);
		for (int i = 0; i < OWN_COUNT; ++i) {
			if (!g_owned[i]) {
				continue;
			}
			if (!IsAlive(g_owned[i])) {
				SetLine(i, L"hata");
			}
		}
	}
}

DWORD WINAPI StartThread(LPVOID) {
	EnsureMaria();

	for (int i = 0; i < OWN_COUNT; ++i) {
		if (i == OWN_PHP) {
			const std::wstring php = FindPhp();
			LaunchOne(i, php, L"-S 127.0.0.1:8080 -t \"C:\\Works\\work1\\panel\" \"C:\\Works\\work1\\panel\\router.php\"");
		} else {
			LaunchOne(i, kExe[i], L"");
		}
		if (kPort[i] != 0 && !IsPortListening(kPort[i])) {
			const ULONGLONG start = GetTickCount64();
			while (GetTickCount64() - start < 8000) {
				if (IsPortListening(kPort[i])) {
					break;
				}
				if (g_owned[i] && !IsAlive(g_owned[i])) {
					break;
				}
				Sleep(200);
			}
			if (g_owned[i] && !IsAlive(g_owned[i])) {
				SetLine(i, L"hata");
			} else if (IsPortListening(kPort[i])) {
				SetLine(i, L"\u00E7al\u0131\u015F\u0131yor");
			}
		}
	}

	WatchOwned();
	if (g_hwnd) {
		PostMessageW(g_hwnd, WM_APP_DONE, 0, 0);
	}
	return 0;
}

DWORD WINAPI StopThread(LPVOID) {
	PerformStop();
	if (g_hwnd) {
		PostMessageW(g_hwnd, WM_APP_DONE, 0, 0);
	}
	return 0;
}

DWORD WINAPI ElevateStopThread(LPVOID) {
	const std::wstring path = StatusPath();
	if (!path.empty()) {
		DeleteFileW(path.c_str());
	}
	const ElevateResult elevated = ElevateAndWait(L"--stop");
	if (!elevated.launched) {
		if (elevated.error == ERROR_CANCELLED) {
			SetMaria(L"Durdurma iptal (UAC onaylanmad\u0131)");
		} else {
			SetMaria(L"hata (" + std::to_wstring(elevated.error) + L")");
		}
	} else if (!LoadStatus()) {
		SetMaria(IsPortListening(3306) ? L"MariaDB: \u00E7al\u0131\u015F\u0131yor" : L"MariaDB: kapal\u0131");
	}
	if (g_hwnd) {
		PostMessageW(g_hwnd, WM_APP_DONE, 0, 0);
	}
	return 0;
}

void BeginWorker(LPTHREAD_START_ROUTINE routine) {
	if (g_busy) {
		return;
	}
	g_busy = true;
	EnableWindow(g_start, FALSE);
	EnableWindow(g_stop, FALSE);
	EnableWindow(g_clear, FALSE);
	const HANDLE thread = CreateThread(nullptr, 0, routine, nullptr, 0, nullptr);
	if (!thread) {
		g_busy = false;
		EnableWindow(g_start, TRUE);
		EnableWindow(g_stop, TRUE);
		EnableWindow(g_clear, TRUE);
		SetMaria(L"hata");
		return;
	}
	CloseHandle(thread);
}

bool StartsWith(const std::wstring& value, const wchar_t* prefix) {
	const size_t n = wcslen(prefix);
	return value.size() >= n && value.compare(0, n, prefix) == 0;
}

std::wstring TrimCopy(std::wstring value) {
	while (!value.empty() && (value.back() == L' ' || value.back() == L'\t' || value.back() == L'\r' || value.back() == L'\n' || value.back() == L'"')) {
		value.pop_back();
	}
	size_t start = 0;
	while (start < value.size() && (value[start] == L' ' || value[start] == L'\t' || value[start] == L'"')) {
		++start;
	}
	return value.substr(start);
}

std::wstring DirName(const std::wstring& path) {
	const size_t pos = path.find_last_of(L"\\/");
	if (pos == std::wstring::npos) {
		return L"";
	}
	return path.substr(0, pos);
}

std::wstring SlashToBack(std::wstring path) {
	for (wchar_t& ch : path) {
		if (ch == L'/') {
			ch = L'\\';
		}
	}
	return path;
}

bool IsClientLogName(const std::wstring& fileName) {
	const std::wstring name = ToLower(fileName);
	if (name == L"syserr.txt" || name == L"log.txt" || name == L"syslog" || name == L"syslog.txt") {
		return true;
	}
	if (name == L"stdout" || name == L"stdout.txt" || name == L"stderr" || name == L"stderr.txt") {
		return true;
	}
	if (name == L"errorlog" || name == L"errorlog.txt") {
		return true;
	}
	return StartsWith(name, L"syslog.") || StartsWith(name, L"errorlog.") || StartsWith(name, L"syserr.");
}

bool IsServerLogName(const std::wstring& fileName) {
	const std::wstring name = ToLower(fileName);
	if (name == L"syserr.txt" || name == L"syslog.txt" || name == L"stdout" || name == L"stderr") {
		return true;
	}
	if (name == L"stdout.txt" || name == L"stderr.txt" || name == L"pts" || name == L"pts.txt") {
		return true;
	}
	if (name == L"packet_info.txt" || name == L"p2p_packet_info.txt" || name == L"udp_packet_info.txt") {
		return true;
	}
	if (StartsWith(name, L"syserr.txt.") || StartsWith(name, L"syslog.txt.") || StartsWith(name, L"pts.txt.")) {
		return true;
	}
	if (StartsWith(name, L"syserr.") && EndsWithI(name, L".txt")) {
		return true;
	}
	if (StartsWith(name, L"syslog.") && EndsWithI(name, L".txt")) {
		return true;
	}
	const bool packet = name.find(L"packet") != std::wstring::npos;
	const bool logWord = name.find(L"log") != std::wstring::npos || name.find(L"info") != std::wstring::npos;
	return packet && logWord && EndsWithI(name, L".txt");
}

bool IsProtectedMariaName(const std::wstring& name) {
	if (name.find(L"ibdata") != std::wstring::npos || name.find(L"ib_logfile") != std::wstring::npos || name.find(L"ib_buffer") != std::wstring::npos) {
		return true;
	}
	if (StartsWith(name, L"aria_log")) {
		return true;
	}
	if (name.find(L"mysql-bin") != std::wstring::npos || name.find(L"mariadb-bin") != std::wstring::npos || name.find(L"binlog") != std::wstring::npos) {
		return true;
	}
	if (name.find(L"relay-bin") != std::wstring::npos || name.find(L"relay-log") != std::wstring::npos) {
		return true;
	}
	return EndsWithI(name, L".ibd");
}

bool IsMariaTextLogName(const std::wstring& fileName) {
	const std::wstring name = ToLower(fileName);
	if (IsProtectedMariaName(name)) {
		return false;
	}
	if (EndsWithI(name, L".err") || EndsWithI(name, L".log")) {
		return true;
	}
	const bool slowOrGeneral = name.find(L"slow") != std::wstring::npos || name.find(L"general") != std::wstring::npos;
	return slowOrGeneral && EndsWithI(name, L".txt");
}

bool ClearOneFile(const std::wstring& path) {
	DWORD attr = GetFileAttributesW(path.c_str());
	if (attr == INVALID_FILE_ATTRIBUTES || (attr & FILE_ATTRIBUTE_DIRECTORY) != 0) {
		return false;
	}
	if ((attr & FILE_ATTRIBUTE_READONLY) != 0) {
		SetFileAttributesW(path.c_str(), attr & ~FILE_ATTRIBUTE_READONLY);
	}
	if (DeleteFileW(path.c_str())) {
		return true;
	}
	const HANDLE file = CreateFileW(path.c_str(), GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
	if (file == INVALID_HANDLE_VALUE) {
		return false;
	}
	LARGE_INTEGER zero{};
	const BOOL ok = SetFilePointerEx(file, zero, nullptr, FILE_BEGIN) && SetEndOfFile(file);
	CloseHandle(file);
	return ok == TRUE;
}

void ClearMatching(const std::wstring& dir, bool recurse, bool (*match)(const std::wstring&), int& cleared, int& failed) {
	WIN32_FIND_DATAW data{};
	const HANDLE find = FindFirstFileW((dir + L"\\*").c_str(), &data);
	if (find == INVALID_HANDLE_VALUE) {
		return;
	}
	do {
		if (data.cFileName[0] == L'.' && (data.cFileName[1] == 0 || (data.cFileName[1] == L'.' && data.cFileName[2] == 0))) {
			continue;
		}
		const std::wstring full = dir + L"\\" + data.cFileName;
		if ((data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) != 0) {
			if (recurse && (data.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) == 0) {
				ClearMatching(full, true, match, cleared, failed);
			}
			continue;
		}
		if (!match(data.cFileName)) {
			continue;
		}
		if (ClearOneFile(full)) {
			++cleared;
		} else {
			++failed;
		}
	} while (FindNextFileW(find, &data));
	FindClose(find);
}

std::wstring ServiceArg(const std::wstring& command, const wchar_t* key) {
	const std::wstring needle = std::wstring(L"--") + ToLower(key);
	const std::wstring lower = ToLower(command);
	size_t pos = 0;
	while ((pos = lower.find(needle, pos)) != std::wstring::npos) {
		size_t i = pos + needle.size();
		if (i < command.size() && command[i] != L'=' && command[i] != L' ' && command[i] != L'\t' && command[i] != L'"') {
			pos = i;
			continue;
		}
		while (i < command.size() && (command[i] == L'=' || command[i] == L' ' || command[i] == L'\t')) {
			++i;
		}
		if (i >= command.size()) {
			return L"";
		}
		if (command[i] == L'"') {
			const size_t end = command.find(L'"', i + 1);
			if (end == std::wstring::npos) {
				return command.substr(i + 1);
			}
			return command.substr(i + 1, end - (i + 1));
		}
		size_t end = i;
		while (end < command.size() && command[end] != L'"') {
			if (command[end] == L' ' && end + 2 < command.size() && command[end + 1] == L'-' && command[end + 2] == L'-') {
				break;
			}
			++end;
		}
		while (end > i && (command[end - 1] == L' ' || command[end - 1] == L'\t')) {
			--end;
		}
		return command.substr(i, end - i);
	}
	return L"";
}

std::wstring ExeFromService(const std::wstring& command) {
	const std::wstring text = TrimCopy(command);
	if (!text.empty() && text[0] == L'"') {
		const size_t end = text.find(L'"', 1);
		if (end != std::wstring::npos) {
			return text.substr(1, end - 1);
		}
	}
	const size_t space = text.find(L' ');
	if (space == std::wstring::npos) {
		return text;
	}
	return text.substr(0, space);
}

std::wstring IniValue(const std::wstring& text, const wchar_t* wantedKey) {
	const std::wstring wanted = ToLower(wantedKey);
	size_t lineStart = 0;
	while (lineStart < text.size()) {
		size_t lineEnd = text.find(L'\n', lineStart);
		if (lineEnd == std::wstring::npos) {
			lineEnd = text.size();
		}
		std::wstring line = TrimCopy(text.substr(lineStart, lineEnd - lineStart));
		lineStart = lineEnd + 1;
		if (line.empty() || line[0] == L'#' || line[0] == L';' || line[0] == L'[') {
			continue;
		}
		const size_t eq = line.find(L'=');
		if (eq == std::wstring::npos) {
			continue;
		}
		std::wstring key = ToLower(TrimCopy(line.substr(0, eq)));
		for (wchar_t& ch : key) {
			if (ch == L'_') {
				ch = L'-';
			}
		}
		if (key != wanted) {
			continue;
		}
		std::wstring value = line.substr(eq + 1);
		bool quoted = false;
		for (size_t i = 0; i < value.size(); ++i) {
			if (value[i] == L'"') {
				quoted = !quoted;
			} else if (!quoted && (value[i] == L'#' || value[i] == L';')) {
				value.resize(i);
				break;
			}
		}
		return SlashToBack(TrimCopy(value));
	}
	return L"";
}

std::wstring ReadTextFile(const std::wstring& path) {
	const HANDLE file = CreateFileW(path.c_str(), GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
	if (file == INVALID_HANDLE_VALUE) {
		return L"";
	}
	LARGE_INTEGER size{};
	if (!GetFileSizeEx(file, &size) || size.QuadPart <= 0 || size.QuadPart > 1024 * 1024) {
		CloseHandle(file);
		return L"";
	}
	std::vector<unsigned char> bytes(static_cast<size_t>(size.QuadPart));
	DWORD read = 0;
	const BOOL ok = ReadFile(file, bytes.data(), static_cast<DWORD>(bytes.size()), &read, nullptr);
	CloseHandle(file);
	if (!ok || read == 0) {
		return L"";
	}
	bytes.resize(read);
	if (bytes.size() >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
		const auto* wide = reinterpret_cast<const wchar_t*>(bytes.data() + 2);
		return std::wstring(wide, wide + ((bytes.size() - 2) / sizeof(wchar_t)));
	}
	size_t offset = 0;
	if (bytes.size() >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) {
		offset = 3;
	}
	const char* chars = reinterpret_cast<const char*>(bytes.data() + offset);
	const int length = static_cast<int>(bytes.size() - offset);
	int flags = MB_ERR_INVALID_CHARS;
	UINT codePage = CP_UTF8;
	int count = MultiByteToWideChar(codePage, flags, chars, length, nullptr, 0);
	if (count <= 0) {
		codePage = CP_ACP;
		flags = 0;
		count = MultiByteToWideChar(codePage, flags, chars, length, nullptr, 0);
	}
	if (count <= 0) {
		return L"";
	}
	std::wstring text(static_cast<size_t>(count), L'\0');
	MultiByteToWideChar(codePage, flags, chars, length, &text[0], count);
	return text;
}

std::wstring MariaDataDir() {
	ServiceInfo service{};
	if (!FindMariaService(service)) {
		return L"";
	}
	std::wstring dir = SlashToBack(ServiceArg(service.binary, L"datadir"));
	const std::wstring defaults = SlashToBack(ServiceArg(service.binary, L"defaults-file"));
	std::wstring ini;
	if (!defaults.empty()) {
		ini = ReadTextFile(defaults);
	}
	if (dir.empty() && !ini.empty()) {
		dir = IniValue(ini, L"datadir");
	}
	if (dir.empty() && !defaults.empty()) {
		const std::wstring parent = DirName(defaults);
		if (DirExists(parent) && (FileExists(parent + L"\\ibdata1") || DirExists(parent + L"\\mysql"))) {
			dir = parent;
		}
	}
	if (dir.empty()) {
		const std::wstring data = DirName(DirName(ExeFromService(service.binary))) + L"\\data";
		if (DirExists(data)) {
			dir = data;
		}
	}
	while (!dir.empty() && (dir.back() == L'\\' || dir.back() == L'/')) {
		dir.pop_back();
	}
	return dir;
}

void ClearLogs() {
	int cleared = 0;
	int failed = 0;
	ClearMatching(L"C:\\Works\\work1\\client", true, IsClientLogName, cleared, failed);
	ClearMatching(L"C:\\Works\\work1\\server", true, IsServerLogName, cleared, failed);
	const std::wstring dataDir = MariaDataDir();
	if (!dataDir.empty() && DirExists(dataDir)) {
		ClearMatching(dataDir, false, IsMariaTextLogName, cleared, failed);
	}
	const DWORD buildAttr = GetFileAttributesW(L"C:\\Works\\work1\\out\\build.log");
	if (buildAttr != INVALID_FILE_ATTRIBUTES && (buildAttr & FILE_ATTRIBUTE_DIRECTORY) == 0) {
		if (ClearOneFile(L"C:\\Works\\work1\\out\\build.log")) {
			++cleared;
		} else {
			++failed;
		}
	}
	if (!g_log) {
		return;
	}
	std::wstring text = BuildText();
	text += L"\r\nLoglar temizlendi: ";
	text += std::to_wstring(cleared);
	if (failed > 0) {
		text += L" (silinemedi: ";
		text += std::to_wstring(failed);
		text += L")";
	}
	SetWindowTextW(g_log, text.c_str());
}

void ApplyFont(HWND child) {
	SendMessageW(child, WM_SETFONT, reinterpret_cast<WPARAM>(g_font), TRUE);
}

void Layout(HWND hwnd) {
	RECT rect{};
	GetClientRect(hwnd, &rect);
	const int margin = 12;
	const int buttonH = 32;
	const int startW = 100;
	const int stopW = 100;
	const int clearW = 168;
	const int gap = 8;
	MoveWindow(g_start, margin, margin, startW, buttonH, TRUE);
	MoveWindow(g_stop, margin + startW + gap, margin, stopW, buttonH, TRUE);
	MoveWindow(g_clear, margin + startW + gap + stopW + gap, margin, clearW, buttonH, TRUE);
	const int top = margin + buttonH + 12;
	MoveWindow(g_log, margin, top, rect.right - margin * 2, rect.bottom - top - margin, TRUE);
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
	switch (msg) {
	case WM_CREATE: {
		g_start = CreateWindowExW(0, L"BUTTON", L"Ba\u015Flat", WS_CHILD | WS_VISIBLE | WS_TABSTOP,
			0, 0, 0, 0, hwnd, reinterpret_cast<HMENU>(static_cast<INT_PTR>(IDC_START)), g_inst, nullptr);
		g_stop = CreateWindowExW(0, L"BUTTON", L"Durdur", WS_CHILD | WS_VISIBLE | WS_TABSTOP,
			0, 0, 0, 0, hwnd, reinterpret_cast<HMENU>(static_cast<INT_PTR>(IDC_STOP)), g_inst, nullptr);
		g_clear = CreateWindowExW(0, L"BUTTON", L"Loglar\u0131 temizle", WS_CHILD | WS_VISIBLE | WS_TABSTOP,
			0, 0, 0, 0, hwnd, reinterpret_cast<HMENU>(static_cast<INT_PTR>(IDC_CLEAR)), g_inst, nullptr);
		g_log = CreateWindowExW(WS_EX_CLIENTEDGE, L"EDIT", L"Haz\u0131r",
			WS_CHILD | WS_VISIBLE | ES_MULTILINE | ES_AUTOVSCROLL | ES_READONLY | WS_VSCROLL,
			0, 0, 0, 0, hwnd, reinterpret_cast<HMENU>(static_cast<INT_PTR>(IDC_LOG)), g_inst, nullptr);
		ApplyFont(g_start);
		ApplyFont(g_stop);
		ApplyFont(g_clear);
		ApplyFont(g_log);
		Layout(hwnd);
		return 0;
	}
	case WM_SIZE:
		Layout(hwnd);
		return 0;
	case WM_COMMAND:
		if (LOWORD(wParam) == IDC_START && HIWORD(wParam) == BN_CLICKED) {
			BeginWorker(StartThread);
		} else if (LOWORD(wParam) == IDC_STOP && HIWORD(wParam) == BN_CLICKED) {
			if (IsElevated()) {
				BeginWorker(StopThread);
			} else {
				BeginWorker(ElevateStopThread);
			}
		} else if (LOWORD(wParam) == IDC_CLEAR && HIWORD(wParam) == BN_CLICKED && !g_busy) {
			ClearLogs();
		}
		return 0;
	case WM_APP_STATUS:
		if (g_log && g_viewReady) {
			const std::wstring text = BuildText();
			SetWindowTextW(g_log, text.c_str());
		}
		return 0;
	case WM_APP_DONE:
		g_busy = false;
		EnableWindow(g_start, TRUE);
		EnableWindow(g_stop, TRUE);
		EnableWindow(g_clear, TRUE);
		return 0;
	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	default:
		return DefWindowProcW(hwnd, msg, wParam, lParam);
	}
}

int RunStartMaria() {
	if (!IsElevated()) {
		return 5;
	}
	ServiceInfo service{};
	if (!FindMariaService(service)) {
		return 1;
	}
	DWORD error = 0;
	if (!StartMariaService(service.name, error) && !IsPortListening(3306)) {
		return 1;
	}
	return IsPortListening(3306) ? 0 : 1;
}

}  // namespace

int WINAPI wWinMain(HINSTANCE instance, HINSTANCE, PWSTR, int show) {
	const RunMode mode = ParseRunMode();
	if (mode == RunMode::StartMaria) {
		return RunStartMaria();
	}
	if (mode == RunMode::Stop) {
		InitializeCriticalSection(&g_cs);
		int code = 5;
		if (!IsElevated()) {
			SetMaria(L"hata (y\u00F6netici de\u011Fil)");
			WriteStatus();
		} else {
			code = PerformStop();
		}
		DeleteCriticalSection(&g_cs);
		return code;
	}

	g_inst = instance;
	InitializeCriticalSection(&g_cs);
	SetProcessDPIAware();

	const WNDCLASSEXW cls{
		sizeof(cls),
		CS_HREDRAW | CS_VREDRAW,
		WndProc,
		0,
		0,
		instance,
		nullptr,
		LoadCursorW(nullptr, IDC_ARROW),
		reinterpret_cast<HBRUSH>(COLOR_WINDOW + 1),
		nullptr,
		L"Metin2Launcher",
		nullptr
	};
	if (!RegisterClassExW(&cls)) {
		return 1;
	}

	g_font = CreateFontW(-18, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET,
		OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH | FF_DONTCARE, L"Segoe UI");

	g_hwnd = CreateWindowExW(
		0,
		L"Metin2Launcher",
		L"Metin2 Ba\u015Flat\u0131c\u0131",
		WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		560,
		360,
		nullptr,
		nullptr,
		instance,
		nullptr);
	if (!g_hwnd) {
		return 1;
	}

	ShowWindow(g_hwnd, show);
	UpdateWindow(g_hwnd);

	MSG message{};
	while (GetMessageW(&message, nullptr, 0, 0) > 0) {
		if (!IsDialogMessageW(g_hwnd, &message)) {
			TranslateMessage(&message);
			DispatchMessageW(&message);
		}
	}

	if (g_font) {
		DeleteObject(g_font);
	}
	DeleteCriticalSection(&g_cs);
	return static_cast<int>(message.wParam);
}
