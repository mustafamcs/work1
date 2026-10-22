@echo off
title work1 - hepsini baslat
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

echo == mariadb ==
call "%~dp010_mariadb_baslat.bat"  || ( echo [HATA] mariadb acilmadi & exit /b 1 )
echo == db ==
call "%~dp020_db_baslat.bat"       || ( echo [HATA] db acilmadi & exit /b 1 )
echo == auth ==
call "%~dp022_auth_baslat.bat"     || ( echo [HATA] auth acilmadi & exit /b 1 )
echo == core1.1 ==
call "%~dp024_core_baslat.bat"     || ( echo [HATA] core acilmadi & exit /b 1 )
echo == ch99 ==
call "%~dp026_ch99_baslat.bat"     || ( echo [HATA] ch99 acilmadi & exit /b 1 )

echo.
echo [OK] sunucu ayakta
call "%~dp033_durum.bat"
