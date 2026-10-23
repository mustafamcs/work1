@echo off
title work1 - profil 105 (midschool)
call "%~dp0_ayar.bat"
net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
echo oyun surecleri durduruluyor (mariadb acik kalir)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Where-Object { @(30000,30001,30003,30901) -contains $_.LocalPort } | Select-Object -Expand OwningProcess -Unique | ForEach-Object { Stop-Process -Id $_ -Force -ErrorAction SilentlyContinue }" >nul 2>&1
echo 105> "%KOK%\active_profile"
call :mapallow "%SRV%\channel1\core1" "1 21 41 4 24 44 250 3 23 43 64 63 61 65 62 69 70 67 68 71 104 107 108 109 217 301 302 303 304"
call :mapallow "%SRV%\channel99"      "66 72 73 208 81 112 113 181 182 183 216 351 352 364 367"
echo profil 105 yazildi, surecler geri baslatiliyor...
call "%~dp030_hepsini_baslat.bat"
call "%~dp033_durum.bat"
exit /b 0
:mapallow
cd /d "%~1"
findstr /v /i "MAP_ALLOW" CONFIG > CONFIG.tmp
echo MAP_ALLOW: %~2>> CONFIG.tmp
move /y CONFIG.tmp CONFIG >nul
exit /b 0
