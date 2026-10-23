@echo off
rem work1 - tam gizli cevrim: kapat + temizle + sifirdan ninja build + ac
rem _tam_gizli.vbs uzerinden elevated+gorunmez calisir; tum cikti log\90_tam_cevrim.log
call "%~dp0_ayar.bat"
set "LOGDIR=%~dp0log"
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1
set "MUT=%LOGDIR%\90_tam_cevrim"
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass"

echo %TIME% BASLA > "%MUT%.durum"

rem == 1/4 zorla kapat ==
set T0=%TIME%
%PS% -Command "Get-Process metin2client,db,game,qc,mariadbd,PackMakerLite -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue" >nul 2>&1
call "%~dp0_artik_kapat.bat"
echo %T0% -^> %TIME% KAPAT >> "%MUT%.durum"

rem == 2/4 temizle ==
set T0=%TIME%
%PS% -File "%~dp0_temizle.ps1" -kok "%KOK%" -scriptdir "%~dp0" >nul 2>&1
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1
rd /s /q "%KOK%\Srcs\Server\build_ninja_sc" >nul 2>&1
rd /s /q "%KOK%\Srcs\Client\build_ninja_sc" >nul 2>&1
echo %T0% -^> %TIME% TEMIZLE >> "%MUT%.durum"

rem == 3/4 sifirdan ninja build (51'nin govdesi - elevated baglamda dogrudan) ==
set T0=%TIME%
call "%~dp0_ninja_ic.bat" > "%LOGDIR%\90_build.log" 2>&1
if errorlevel 1 ( echo %T0% -^> %TIME% BUILD_HATA >> "%MUT%.durum" & goto bitti )
echo %T0% -^> %TIME% BUILD >> "%MUT%.durum"

rem == pack guncelleme (sadece degisenler) ==
set T0=%TIME%
call "%~dp074_paket_guncelle.bat" > "%LOGDIR%\90_pack.log" 2>&1
echo %T0% -^> %TIME% PACK >> "%MUT%.durum"

rem == 4/4 sunucu + istemci ==
set T0=%TIME%
call "%~dp030_hepsini_baslat.bat" > "%LOGDIR%\90_baslat.log" 2>&1
if errorlevel 1 ( echo %T0% -^> %TIME% BASLAT_HATA >> "%MUT%.durum" & goto bitti )
call "%~dp070_istemci_baslat.bat" >> "%LOGDIR%\90_baslat.log" 2>&1
echo %T0% -^> %TIME% BASLAT >> "%MUT%.durum"

:bitti
echo %TIME% BITTI >> "%MUT%.durum"
exit /b 0
