@echo off
title work1 - hepsini durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem tek netstat taramasi: oyun portlarinin pid'leri
set "NSF=%TEMP%\work1_ns31.txt"
netstat -ano | findstr "LISTENING" | findstr ":30000 :30001 :30003 :30901" > "%NSF%"
for /f "tokens=5" %%a in ('type "%NSF%"') do start /b "" taskkill /PID %%a /F >nul 2>&1

rem mariadb'yi paralelde nazik kapatmaya basla
if exist "%MYSQLADMIN%" start /b "" "%MYSQLADMIN%" -u %MYSQL_USER% -p%MYSQL_PASS% --protocol=tcp shutdown >nul 2>&1

rem kisa bekleme + tek dogrulama taramasi (core'lar + mariadb birlikte)
powershell -NoProfile -Command "Start-Sleep -Milliseconds 300" >nul 2>&1
netstat -ano | findstr "LISTENING" | findstr ":30000 :30001 :30003 :30901 :3306" > "%NSF%"
for /f "tokens=5" %%a in ('type "%NSF%"') do taskkill /PID %%a /F >nul 2>&1
del /f "%NSF%" >nul 2>&1
echo [OK] oyun core'lari ve mariadb durduruldu

echo.
echo [OK] hepsi durduruldu
call "%~dp033_durum.bat"
