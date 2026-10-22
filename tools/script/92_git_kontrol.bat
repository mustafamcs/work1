@echo off
title work1 - git icerik kontrolu
call "%~dp0_ayar.bat"
rem Izlenen dosyalar arasinda derleme/uretim ciktisi kaldi mi kontrol eder.
cd /d "%KOK%"
set /a ERR=0

echo == izlenen supheli dosyalar ==
for %%P in (*.eix *.epk *.exe *.dll *.pdb *.idb *.ipch *.tlog *.ilk *.bsc *.map
            out/* */_yedek/* */.pre_qc/* */__pycache__/* *.log syserr* syslog*
            packet_info.txt p2p_packet_info.txt active_profile) do (
  for /f %%N in ('git ls-files "%%P" 2^>nul ^| find /c /v ""') do (
    if not "%%N"=="0" (
      echo   [IZLENIYOR] %%P  -^>  %%N dosya
      git ls-files "%%P" | findstr /n "." | findstr "^[1-5]:"
      set /a ERR+=1
    )
  )
)
echo.
echo == buyuk dosyalar ^(^>10 MB, izlenen^) ==
git ls-files -z | python -c "import sys,os;fs=sys.stdin.buffer.read().split(b'\0');b=[f.decode('utf8','replace') for f in fs if f and os.path.exists(f) and os.path.getsize(f)>10485760];print('\n'.join('  %8.1f MB  %s'%(os.path.getsize(f)/1048576,f) for f in sorted(b,key=lambda f:-os.path.getsize(f))))" 2>nul || echo   (python yok, atlandi)
echo.
if %ERR%==0 ( echo [SONUC] temiz - izlenen derleme ciktisi yok ) else ( echo [SONUC] %ERR% supheli desen bulundu )
exit /b %ERR%
