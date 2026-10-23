@echo off
rem 51_ninja_derle'nin govdesi - elevasyon kontrolu yok (elevated baglamda cagrilir)
rem 90_tam_cevrim ve 51 tarafindan kullanilir. /min yerine /b (pencere uretmez).
call "%~dp0_ayar.bat"

set "NINJA_SRV=%KOK%\Srcs\Server\build_ninja_sc"
set "NINJA_CLI=%KOK%\Srcs\Client\build_ninja_sc"
set "SCC=%KOK%\tools\sccache\sccache-v0.18.0-x86_64-pc-windows-msvc\sccache.exe"
set "TDIR=%TEMP%\work1ninja"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Where-Object { @(30000,30001,30003,30901) -contains $_.LocalPort } | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }; Get-Process metin2client -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue" >nul 2>&1

if not exist "%TDIR%" mkdir "%TDIR%" >nul 2>&1
del /f /q "%TDIR%\*.done" "%TDIR%\*.log" >nul 2>&1

rem iki agac paralel derleniyor (vcvars32 + cmake configure + ninja)
start "" /b cmd /c ""%~dp0_ninja_one.bat" "%KOK%\Srcs\Server" "%NINJA_SRV%" "%TDIR%\server.log" "%TDIR%\server.done""
start "" /b cmd /c ""%~dp0_ninja_one.bat" "%KOK%\Srcs\Client" "%NINJA_CLI%" "%TDIR%\client.log" "%TDIR%\client.done""

:wait
powershell -NoProfile -Command "Start-Sleep -Milliseconds 400" >nul
if not exist "%TDIR%\server.done" goto wait
if not exist "%TDIR%\client.done" goto wait
set /p SRVRC=<"%TDIR%\server.done"
set /p CLIRC=<"%TDIR%\client.done"
if not "%SRVRC%"=="0" ( echo [HATA] server derleme basarisiz - log: %TDIR%\server.log & exit /b 1 )
if not "%CLIRC%"=="0" ( echo [HATA] istemci derleme basarisiz - log: %TDIR%\client.log & exit /b 1 )

rem sadece degisen ciktilar dagitiliyor
set "BIN=%NINJA_SRV%\bin"
xcopy /d /y /q "%BIN%\db.exe"   "%SRV%\db\"        >nul 2>&1
xcopy /d /y /q "%BIN%\db.exe"   "%SRV%\share\bin\" >nul 2>&1
xcopy /d /y /q "%BIN%\game.exe" "%SRV%\auth\"           >nul 2>&1
xcopy /d /y /q "%BIN%\game.exe" "%SRV%\channel1\core1\" >nul 2>&1
xcopy /d /y /q "%BIN%\game.exe" "%SRV%\channel99\"      >nul 2>&1
xcopy /d /y /q "%BIN%\game.exe" "%SRV%\share\bin\"      >nul 2>&1
xcopy /d /y /q "%BIN%\qc.exe"   "%QUESTDIR%\"      >nul 2>&1
xcopy /d /y /q "%BIN%\qc.exe"   "%SRV%\share\bin\" >nul 2>&1
for %%D in (DevIL.dll ILU.dll ILUT.dll libmysql.dll) do (
  if exist "%BIN%\%%D" xcopy /d /y /q "%BIN%\%%D" "%SRV%\share\bin\" >nul 2>&1
)
if exist "%NINJA_CLI%\bin\metin2client.exe" xcopy /d /y /q "%NINJA_CLI%\bin\metin2client.exe" "%CLIENTDIR%\" >nul 2>&1

echo [OK] ninja derleme bitti - sccache durumu:
"%SCC%" --show-stats 2>nul | findstr /i "hit"
call "%~dp0_artik_kapat.bat"
exit /b 0
