@echo off
title work1 - degisiklik uygula (pack guncelle + ninja build + dogrulama)
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Degisen paketleri gunceller, server+client'i ninja ile derler, dogrular.
rem Zincir calistirdigi icin tum adimlar tek UAC onayiyla yonetici yetkisinde gider.

echo === pack guncelleme (sadece degisenler) ===
call "%~dp074_paket_guncelle.bat"
if errorlevel 1 ( echo [HATA] pack guncelleme basarisiz & exit /b 1 )

echo.
echo === ninja derleme (server+client) ===
call "%~dp0_ninja_ic.bat"
if errorlevel 1 ( echo [HATA] derleme basarisiz & exit /b 1 )

echo.
echo === dogrulama ===
call "%~dp086_dogrula.bat"
exit /b %errorlevel%
