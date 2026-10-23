@echo off
title work1 - canli guncelle (ninja build + hizli restart)
call "%~dp0_ayar.bat"
net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem server kodunu ninja+sccache ile derle, degisen exe'leri dagit,
rem mariadb'ye dokunmadan db/auth/core/ch99'u yeni binary ile baslat.
call "%~dp051_ninja_derle.bat"
if errorlevel 1 exit /b 1
call "%~dp030_hepsini_baslat.bat"
if errorlevel 1 exit /b 1
echo [OK] canli guncelleme tamamlandi
exit /b 0
