@echo off
title work1 - sql import
call "%~dp0_ayar.bat"

if not exist "%MYSQL_BIN%" ( echo [HATA] mysql.exe yok: %MYSQL_BIN% & exit /b 1 )
netstat -ano | findstr ":3306 " | findstr LISTENING >nul
if not %errorlevel%==0 ( echo [HATA] mariadb kapali - once 10_mariadb_baslat.bat & exit /b 1 )

call "%KOK%\sql\import-windows.bat" %MYSQL_USER% 127.0.0.1 3306 "%MYSQL_BIN%"
