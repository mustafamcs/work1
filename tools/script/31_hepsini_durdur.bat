@echo off
title work1 - hepsini durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem mariadb'yi paralelde nazik kapatmaya basla
if exist "%MYSQLADMIN%" start /b "" "%MYSQLADMIN%" -u %MYSQL_USER% -p%MYSQL_PASS% --protocol=tcp shutdown >nul 2>&1

rem oyun portlarinin pid'lerini bul ve oldur, sonra kalanlari zorla
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ports=30000,30001,30003,30901; $pids=@(Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Where-Object {$ports -contains $_.LocalPort} | Select-Object -Expand OwningProcess -Unique); $pids | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }; Start-Sleep -Milliseconds 250; $kalan=@(Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Where-Object {($ports+3306) -contains $_.LocalPort} | Select-Object -Expand OwningProcess -Unique); $kalan | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }; if($kalan){ exit 1 }" >nul 2>&1

echo [OK] hepsi durduruldu
call "%~dp033_durum.bat"
