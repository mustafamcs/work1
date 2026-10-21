@echo off
rem ============================================================
rem  import-windows.bat  - work1 SQL import betigi (MariaDB 10.11)
rem
rem  sql\schema.sql iceri alinir (account, player, common, log, hotbackup).
rem  Parola dosyaya gomulu degildir; calistirinca sorulur
rem  (MYSQL_PWD ortam degiskeni uzerinden mysql.exe'ye verilir).
rem
rem  Kullanim:
rem    import-windows.bat [kullanici] [host] [port] [mysql.exe-yolu]
rem
rem  Ornek:
rem    import-windows.bat root 127.0.0.1 3306 "C:\Program Files\MariaDB 10.11\bin\mysql.exe"
rem ============================================================
setlocal EnableExtensions

set "MYSQL_USER=%~1"
if "%MYSQL_USER%"=="" set "MYSQL_USER=root"
set "MYSQL_HOST=%~2"
if "%MYSQL_HOST%"=="" set "MYSQL_HOST=127.0.0.1"
set "MYSQL_PORT=%~3"
if "%MYSQL_PORT%"=="" set "MYSQL_PORT=3306"
set "MYSQL_BIN=%~4"
if "%MYSQL_BIN%"=="" set "MYSQL_BIN=mysql.exe"

"%MYSQL_BIN%" --version >nul 2>&1
if errorlevel 1 (
  echo [HATA] mysql.exe bulunamadi: %MYSQL_BIN%
  echo MariaDB 10.11 istemcisinin bin klasorunu PATH'e ekleyin
  echo ya da 4. parametre olarak tam yolu verin.
  exit /b 1
)

set /p "MYSQL_PWD=MySQL sifresi (%MYSQL_USER%@%MYSQL_HOST%:%MYSQL_PORT%): "

set "DIR=%~dp0"

echo schema.sql iceri aliniyor (account, player, common, log, hotbackup) ...
"%MYSQL_BIN%" -h %MYSQL_HOST% -P %MYSQL_PORT% -u %MYSQL_USER% --default-character-set=utf8mb4 < "%DIR%schema.sql"
if errorlevel 1 (
  echo [HATA] schema.sql importu basarisiz.
  exit /b 1
)

echo [OK] Import tamamlandi.
endlocal
exit /b 0
