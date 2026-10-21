/*
 * platform_freebsd.cpp — platform/ katmaninin FreeBSD uygulamasi.
 * BSD soket (init no-op), fork/execvp, pidfile, POSIX yol (UTF-8).
 */
#include "../platform.h"

#ifndef __FreeBSD__
#   error "platform_freebsd.cpp sadece FreeBSD'de derlenir"
#endif

#include <sys/types.h>
#include <sys/wait.h>

#include <errno.h>
#include <limits.h>
#include <signal.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#include <cstdio>
#include <cstring>
#include <string>
#include <vector>

int PlatformInitSockets(void)
{
    // BSD soketlerinde init gerekmez; socket() kapi kapali konusmada
    // SIGPIPE uretmesin diye sinyali yoksay.
    signal(SIGPIPE, SIG_IGN);
    return 1;
}

void PlatformShutdownSockets(void)
{
    // no-op
}

PlatformPid PlatformSpawnProcess(const char* cwd, const char* exe,
                                 const char* const args[])
{
    if (!exe || !*exe)
        return -1;

    // argv: [exe, args..., NULL] — execvp icin argv[0] = exe
    std::vector<char*> argv;
    argv.push_back(const_cast<char*>(exe));
    if (args)
    {
        for (const char* const* it = args; *it; ++it)
            argv.push_back(const_cast<char*>(*it));
    }
    argv.push_back(nullptr);

    const pid_t pid = fork();
    if (pid < 0)
        return -1;
    if (pid == 0)
    {
        // cocuk
        if (cwd && *cwd)
            (void)chdir(cwd);
        execvp(exe, argv.data());
        _exit(127); // exec basarisiz
    }
    return pid;
}

int PlatformTerminateProcess(PlatformPid pid, unsigned gracefulMs)
{
    if (pid <= 0)
        return 0;
    if (kill(pid, SIGTERM) != 0 && errno != ESRCH)
        return 0;

    const struct timespec step{0, 20L * 1000L * 1000L}; // 20 ms
    unsigned waited = 0;
    for (;;)
    {
        int status = 0;
        const pid_t r = waitpid(pid, &status, WNOHANG);
        if (r == pid)
            return 1;
        if (r < 0 && errno == ECHILD)
        {
            // bizim cocugumuz degil: varligini sinyal ile sorgula
            if (kill(pid, 0) != 0 && errno == ESRCH)
                return 1;
        }
        if (waited >= gracefulMs)
            break;
        nanosleep(&step, nullptr);
        waited += 20;
    }

    // hala ayakta: zorla oldur
    if (kill(pid, SIGKILL) != 0 && errno != ESRCH)
        return 0;
    {
        int status = 0;
        (void)waitpid(pid, &status, 0); // cocuk degilse ECHILD — onemsiz
    }
    return 1;
}

int PlatformIsProcessAlive(PlatformPid pid)
{
    if (pid <= 0)
        return 0;

    int status = 0;
    // bizim cocugumuzsa ve olmusse zombie'yi topla
    if (waitpid(pid, &status, WNOHANG) == pid)
        return 0;
    if (kill(pid, 0) == 0)
        return 1;
    return errno == EPERM;
}

int PlatformWritePidFile(const char* dir)
{
    if (!dir || !*dir)
        dir = ".";

    // <prog>.pid — db -> db.pid, game -> game.pid
    const char* prog = getprogname();
    if (!prog || !*prog)
        prog = PlatformDefaultServiceName();

    char path[PATH_MAX];
    const int n = snprintf(path, sizeof(path), "%s/%s.pid", dir, prog);
    if (n <= 0 || static_cast<size_t>(n) >= sizeof(path))
        return 0;

    FILE* fp = fopen(path, "w");
    if (!fp)
        return 0;
    fprintf(fp, "%d\n", static_cast<int>(getpid()));
    fclose(fp);
    return 1;
}

size_t PlatformPathJoin(char* out, size_t outSize,
                        const char* dir, const char* leaf)
{
    // POSIX yol: UTF-8 + '/' ayirac
    std::string d = dir ? dir : "";
    while (!d.empty() && d.back() == '/')
        d.pop_back();
    const std::string l = leaf ? leaf : "";
    const std::string joined = d.empty() ? l : (l.empty() ? d : d + "/" + l);

    if (out && outSize)
    {
        const size_t n = (joined.size() < outSize - 1) ? joined.size() : outSize - 1;
        memcpy(out, joined.data(), n);
        out[n] = '\0';
    }
    return joined.size();
}

const char* PlatformExeSuffix(void)
{
    return "";
}

const char* PlatformDefaultServiceName(void)
{
    return "metin2";
}
