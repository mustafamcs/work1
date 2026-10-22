#include "StdAfx.h"

#include <stdio.h>
#include <time.h>
#include <winsock.h>
#include <imagehlp.h>

FILE * fException;

#ifdef ENABLE_CRASH_MINIDUMP
#include "../UserInterface/Version.h"
#include <iomanip>
#include <sstream>
void make_minidump(EXCEPTION_POINTERS* e)
{
	auto hDbgHelp = LoadLibraryA("dbghelp");
	if (hDbgHelp == nullptr)
		return;
	auto pMiniDumpWriteDump = (decltype(&MiniDumpWriteDump))GetProcAddress(hDbgHelp, "MiniDumpWriteDump");
	if (pMiniDumpWriteDump == nullptr)
		return;
	// folder name
	std::string folder = "logs";
	CreateDirectoryA(folder.c_str(), nullptr);
	// time format
	auto t = std::time(nullptr);
	std::ostringstream timefmt;
	timefmt << std::put_time(std::localtime(&t), "%Y%m%d_%H%M%S");
	// filename
	std::string filename = folder + "\\"s + "metin2client_"s + std::to_string(METIN2_GET_VERSION()) + "_"s + timefmt.str() + ".dmp";

	auto hFile = CreateFileA(filename.c_str(), GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
	if (hFile == INVALID_HANDLE_VALUE)
		return;

	MINIDUMP_EXCEPTION_INFORMATION exceptionInfo;
	exceptionInfo.ThreadId = GetCurrentThreadId();
	exceptionInfo.ExceptionPointers = e;
	exceptionInfo.ClientPointers = FALSE;

	auto dumped = pMiniDumpWriteDump(
		GetCurrentProcess(),
		GetCurrentProcessId(),
		hFile,
		MINIDUMP_TYPE(MiniDumpWithIndirectlyReferencedMemory | MiniDumpScanMemory),
		e ? &exceptionInfo : nullptr,
		nullptr,
		nullptr);

	CloseHandle(hFile);

	// std::string errMsg = "The application crashed. Send the generated file to the staff: "s + name;
	// MessageBox(nullptr, errMsg.c_str(), "Metin2Client", MB_ICONSTOP);

	return;
}
#endif

LONG __stdcall EterExceptionFilter(_EXCEPTION_POINTERS * pExceptionInfo)
{
	// crash bilgisini logs\crash.txt'ye yaz (symboldan fonksiyon adi cozulur)
	{
		FILE* fp = fopen("logs\\crash.txt", "w");
		if (fp)
		{
			DWORD dwCode = pExceptionInfo->ExceptionRecord->ExceptionCode;
			DWORD dwAddr = (DWORD)pExceptionInfo->ExceptionRecord->ExceptionAddress;
			fprintf(fp, "code=0x%08X addr=0x%08X\n", dwCode, dwAddr);

			HMODULE hDbgHelp = LoadLibraryA("dbghelp");
			if (hDbgHelp)
			{
				typedef BOOL (WINAPI *tSI)(HANDLE, PCSTR, BOOL);
				typedef BOOL (WINAPI *tSFA)(HANDLE, DWORD64, PDWORD64, void*);
				tSI pSymInitialize = (tSI)GetProcAddress(hDbgHelp, "SymInitialize");
				tSFA pSymFromAddr = (tSFA)GetProcAddress(hDbgHelp, "SymFromAddr");
				typedef BOOL (WINAPI *tSW)(DWORD, HANDLE, HANDLE, LPSTACKFRAME64, PVOID,
					PREAD_PROCESS_MEMORY_ROUTINE64, PFUNCTION_TABLE_ACCESS_ROUTINE64,
					PGET_MODULE_BASE_ROUTINE64, PTRANSLATE_ADDRESS_ROUTINE64);
				tSW pStackWalk = (tSW)GetProcAddress(hDbgHelp, "StackWalk64");
				PFUNCTION_TABLE_ACCESS_ROUTINE64 pFTA = (PFUNCTION_TABLE_ACCESS_ROUTINE64)GetProcAddress(hDbgHelp, "SymFunctionTableAccess64");
				PGET_MODULE_BASE_ROUTINE64 pGMB = (PGET_MODULE_BASE_ROUTINE64)GetProcAddress(hDbgHelp, "SymGetModuleBase64");
				if (pSymInitialize && pSymFromAddr && pStackWalk && pFTA && pGMB)
				{
					HANDLE hProc = GetCurrentProcess();
					if (pSymInitialize(hProc, NULL, TRUE))
					{
						unsigned char symBuf[sizeof(SYMBOL_INFO) + 256];
						SYMBOL_INFO* si = (SYMBOL_INFO*)symBuf;
						memset(symBuf, 0, sizeof(symBuf));
						si->SizeOfStruct = sizeof(SYMBOL_INFO);
						si->MaxNameLen = 255;
						DWORD64 disp = 0;
						if (pSymFromAddr(hProc, dwAddr, &disp, si))
							fprintf(fp, "func=%s+0x%X\n", si->Name, (DWORD)disp);

						CONTEXT ctx = *pExceptionInfo->ContextRecord;
						STACKFRAME64 sf;
						memset(&sf, 0, sizeof(sf));
						sf.AddrPC.Offset    = ctx.Eip;
						sf.AddrStack.Offset = ctx.Esp;
						sf.AddrFrame.Offset = ctx.Ebp;
						sf.AddrPC.Mode    = AddrModeFlat;
						sf.AddrStack.Mode = AddrModeFlat;
						sf.AddrFrame.Mode = AddrModeFlat;
						for (int i = 0; i < 24; ++i)
						{
							if (!pStackWalk(IMAGE_FILE_MACHINE_I386, hProc, GetCurrentThread(), &sf, &ctx, NULL, pFTA, pGMB, NULL))
								break;
							if (sf.AddrPC.Offset == 0)
								break;
							disp = 0;
							if (pSymFromAddr(hProc, sf.AddrPC.Offset, &disp, si))
								fprintf(fp, "  0x%08X %s+0x%X\n", (DWORD)sf.AddrPC.Offset, si->Name, (DWORD)disp);
							else
								fprintf(fp, "  0x%08X ?\n", (DWORD)sf.AddrPC.Offset);
						}
					}
				}
			}
			fclose(fp);
		}
	}
#ifdef ENABLE_CRASH_MINIDUMP
	make_minidump(pExceptionInfo);
#else
	// eterlog trash
#endif
	return EXCEPTION_EXECUTE_HANDLER;
}

void SetEterExceptionHandler()
{
	SetUnhandledExceptionFilter(EterExceptionFilter);
}

