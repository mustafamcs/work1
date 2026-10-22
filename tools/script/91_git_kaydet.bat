@echo off
title work1 - git commit + push
call "%~dp0_ayar.bat"
rem Kullanim: 91_git_kaydet.bat "commit mesaji"
rem Tum degisiklikleri ekler, verilen mesajla commit'ler, main'e pushlar.

if "%~1"=="" ( echo Kullanim: %~n0 "commit mesaji" & exit /b 1 )
cd /d "%KOK%"

git status --short >nul 2>&1
for /f %%N in ('git status --porcelain ^| find /c /v ""') do set ADET=%%N
if "%ADET%"=="0" ( echo [OK] commitlenecek degisiklik yok & exit /b 0 )

git add -A
git commit -m "%~1"
if errorlevel 1 ( echo [HATA] commit basarisiz & exit /b 1 )

git push origin main
if errorlevel 1 ( echo [HATA] push basarisiz & exit /b 1 )
echo.
echo [OK] %ADET% dosya degisikligi commitlendi ve push edildi
exit /b 0
