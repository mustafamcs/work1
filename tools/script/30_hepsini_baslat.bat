@echo off
title work1 - hepsini baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass"

rem === mariadb ===
%PS% -File "%~dp0_port_acik.ps1" 3306 >nul 2>&1
if not errorlevel 1 goto mariadb_ok
cscript //nologo "%~dp0_gizli_baslat.vbs" "%KOK%" "%MARIADB_EXE%" "--defaults-file=%MARIADB_INI%" >nul
%PS% -File "%~dp0_port_bekle.ps1" 3306 15 >nul 2>&1
if errorlevel 1 ( echo [HATA] mariadb 3306 acilmadi & exit /b 1 )
:mariadb_ok
echo [OK] mariadb :3306

rem === db ===
%PS% -File "%~dp0_port_acik.ps1" 30000 >nul 2>&1
if not errorlevel 1 goto db_ok
cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\db" "%SRV%\db\db.exe" >nul
%PS% -File "%~dp0_port_bekle.ps1" 30000 15 >nul 2>&1
if errorlevel 1 ( echo [HATA] db 30000 acilmadi - %SRV%\db\syserr.txt & exit /b 1 )
:db_ok
echo [OK] db :30000

rem === auth + core1 + ch99: paralel baslat, tek beklemede hepsini izle ===
%PS% -File "%~dp0_port_acik.ps1" 30001 >nul 2>&1
if errorlevel 1 cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\auth" "%SRV%\auth\game.exe" >nul

%PS% -File "%~dp0_port_acik.ps1" 30003 >nul 2>&1
if errorlevel 1 cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\channel1\core1" "%SRV%\channel1\core1\game.exe" >nul

%PS% -File "%~dp0_port_acik.ps1" 30901 >nul 2>&1
if errorlevel 1 cscript //nologo "%~dp0_gizli_baslat.vbs" "%SRV%\channel99" "%SRV%\channel99\game.exe" >nul

%PS% -Command "$ports=30001,30003,30901; $t=[Diagnostics.Stopwatch]::StartNew(); while($t.Elapsed.TotalSeconds -lt 20){ $acik=@($ports | Where-Object { Get-NetTCPConnection -State Listen -LocalPort $_ -ErrorAction SilentlyContinue }); if($acik.Count -eq 3){ exit 0 }; Start-Sleep -Milliseconds 100 }; exit 1" >nul 2>&1
if errorlevel 1 ( echo [HATA] auth/core1/ch99 portlari acilmadi & exit /b 1 )

echo [OK] auth :30001 / core1 :30003 / ch99 :30901
echo.
echo [OK] sunucu ayakta
call "%~dp033_durum.bat"
