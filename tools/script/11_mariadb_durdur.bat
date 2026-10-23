@echo off
title work1 - mariadb durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass"

%PS% -File "%~dp0_port_acik.ps1" 3306 >nul 2>&1
if errorlevel 1 ( echo [OK] mariadb zaten kapali & exit /b 0 )

rem once nazik kapanis, arka planda porta gore 100ms poll ile bekle
if exist "%MYSQLADMIN%" (
  "%MYSQLADMIN%" -u %MYSQL_USER% -p%MYSQL_PASS% --protocol=tcp shutdown >nul 2>&1
  %PS% -Command "$t=[Diagnostics.Stopwatch]::StartNew(); while($t.Elapsed.TotalSeconds -lt 3 -and (Get-NetTCPConnection -State Listen -LocalPort 3306 -ErrorAction SilentlyContinue)){ Start-Sleep -Milliseconds 100 }; if(-not (Get-NetTCPConnection -State Listen -LocalPort 3306 -ErrorAction SilentlyContinue)){ exit 0 } else { exit 1 }" >nul 2>&1
  if not errorlevel 1 ( echo [OK] mariadb nazik kapandi & exit /b 0 )
  echo [UYARI] mysqladmin yetmedi, surec kapatiliyor...
)

%PS% -Command "$c=Get-NetTCPConnection -State Listen -LocalPort 3306 -ErrorAction SilentlyContinue; if($c){ $c | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force } } else { exit 1 }" >nul 2>&1
if errorlevel 1 ( echo [HATA] mariadb kapatilamadi & exit /b 1 )
echo [OK] mariadb durduruldu
