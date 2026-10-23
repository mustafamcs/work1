@echo off
title work1 - degisiklik uygula (repack + client build + dogrulama)
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Degisiklik yapilan paketleri repack eder, istemciyi derler, dogrular.
rem Zincir calistirdigi icin tum adimlar tek UAC onayiyla yonetici yetkisinde gider.

set /a ERR=0
for %%P in (root uiscript locale special_patch_common) do (
  echo.
  echo === repack: %%P ===
  call "%~dp071_paket_repack.bat" %%P
  if errorlevel 1 ( set /a ERR+=1 )
)
if %ERR% neq 0 ( echo [HATA] repack asamasinda hata & exit /b 1 )

echo.
echo === istemci derleme ===
call "%~dp044_build_client.bat"
if errorlevel 1 ( echo [HATA] istemci derleme basarisiz & exit /b 1 )

echo.
echo === dogrulama ===
call "%~dp086_dogrula.bat"
exit /b %errorlevel%
