@echo off
title work1 - mariadb durdur
call "%~dp0_ayar.bat"

netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [OK] mariadb zaten kapali & exit /b 0 )

rem once nazik kapanis (SHUTDOWN yetkisi varsa)
if exist "%MYSQLADMIN%" (
  "%MYSQLADMIN%" -u %MYSQL_USER% -p%MYSQL_PASS% --protocol=tcp shutdown >nul 2>&1
  ping -n 4 127.0.0.1 >nul
  netstat -ano | findstr ":3306 " | findstr LISTENING >nul
  if not %errorlevel%==0 ( echo [OK] mariadb nazik kapandi & exit /b 0 )
  echo [UYARI] mysqladmin yetmedi, surec kapatiliyor...
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3306 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [HATA] mariadb kapatilamadi & exit /b 1 )
echo [OK] mariadb durduruldu
