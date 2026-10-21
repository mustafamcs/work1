#pragma once

/*
 * platform.h — OS soyutlama katmaninin ortak API'si.
 *
 * Oyun kodu dogrudan OS cagrisi yapmaz; Windows/FreeBSD ayrimi bu katmanda
 * toplanir. Uygulama (implementation) OS'e gore secilir:
 *   _WIN32      -> win/platform_win.cpp
 *                  (Winsock2, CreateProcessW + Job Object, UTF-16 dosya API, hizmet)
 *   __FreeBSD__ -> freebsd/platform_freebsd.cpp
 *                  (BSD soket, fork/execvp, pidfile, rc)
 */

#include <stddef.h> /* size_t */

#if defined(_WIN32)
#   define PLATFORM_OS_WINDOWS 1
typedef unsigned long PlatformPid;      /* DWORD */
#elif defined(__FreeBSD__)
#   define PLATFORM_OS_FREEBSD 1
typedef int PlatformPid;                /* pid_t */
#else
#   error "platform/: sadece _WIN32 ve __FreeBSD__ destekleniyor"
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Soket alt sistemini hazirlar.
 * Windows: WSAStartup(2.2). FreeBSD: no-op + SIGPIPE'i yoksayar.
 * Donus: basariliysa sifirdan farkli.
 */
int PlatformInitSockets(void);
void PlatformShutdownSockets(void);

/*
 * cwd altinda exe'yi args ile baslatir.
 *   args: NULL-sonlu arguman dizisi (argv[0] haric, NULL olabilir).
 *   Donus: cocuk pid'i; hata durumunda <= 0.
 * Windows'ta cocuk, ust surec kapaninca otomatik oldurulmesi icin
 * bir Job Object'e (kill-on-close) atanir.
 */
PlatformPid PlatformSpawnProcess(const char* cwd, const char* exe,
                                 const char* const args[]);

/*
 * pid'li sureci sonlandirir: once nazik sinyal gonderir (SIGTERM / konsol kirma),
 * gracefulMs boyunca cikisini bekler, hala ayaktaysa zorla oldurur
 * (SIGKILL / TerminateProcess). Donus: surec durdurulduysa sifirdan farkli.
 */
int PlatformTerminateProcess(PlatformPid pid, unsigned gracefulMs);

/* pid'li surec ayakta mi? (olu cocuklar toplanir) */
int PlatformIsProcessAlive(PlatformPid pid);

/*
 * Calisan surecin pid'ini <dir>/<calisan-adi>.pid olarak yazar.
 * dir NULL/bos ise gecerli dizin kullanilir. Donus: basari sifirdan farkli.
 */
int PlatformWritePidFile(const char* dir);

/*
 * dir + leaf yol birlestirmesi.
 * Giris/cikis UTF-8'dir; Windows tarafi ic API'de UTF-16 kullanir.
 * out'a '\0'-sonlu yazar, gereken (sonlandirici haric) uzunlugu dondurur.
 * out NULL ya da kucukse donen deger ile tampon boyutu karsilastirilabilir.
 */
size_t PlatformPathJoin(char* out, size_t outSize,
                        const char* dir, const char* leaf);

/* Calistirilabilir dosya uzantisi: Windows'ta ".exe", FreeBSD'de "" */
const char* PlatformExeSuffix(void);

/* Hizmet/rc icin varsayilan ad ("metin2") */
const char* PlatformDefaultServiceName(void);

#ifdef __cplusplus
} /* extern "C" */
#endif
