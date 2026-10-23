@echo off
title work1 - mariadb durdur
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [OK] mariadb zaten kapali & exit /b 0 )

rem once nazik kapanis (SHUTDOWN yetkisi varsa) - hizli poll ile bekle
if exist "%MYSQLADMIN%" (
  "%MYSQLADMIN%" -u %MYSQL_USER% -p%MYSQL_PASS% --protocol=tcp shutdown >nul 2>&1
  set N=0
  :bekele
  netstat -ano | findstr ":3306 " | findstr LISTENING >nul
  if not %errorlevel%==0 ( echo [OK] mariadb nazik kapandi & exit /b 0 )
  set /a N+=1
  if %N% LSS 8 ( powershell -NoProfile -Command "Start-Sleep -Milliseconds 200" >nul & goto bekele )
  echo [UYARI] mysqladmin yetmedi, surec kapatiliyor...
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3306 " ^| findstr LISTENING') do taskkill /PID %%a /F >nul 2>&1
netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if %errorlevel%==0 ( echo [HATA] mariadb kapatilamadi & exit /b 1 )
echo [OK] mariadb durduruldu
