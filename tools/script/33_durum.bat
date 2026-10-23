@echo off
title work1 - durum
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

set "PROFIL="
for /f %%p in ('type "%KOK%\active_profile" 2^>nul') do set "PROFIL=%%p"
echo aktif profil: %PROFIL%
echo ------------------------------------------
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$srv=@(@('mariadb',3306),@('db',30000),@('auth',30001),@('core1.1',30003),@('ch99',30901)); $listen=@{}; Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | ForEach-Object { $listen[$_.LocalPort]=$true }; foreach($s in $srv){ if($listen[$s[1]]){ Write-Host ('  {0} [:{1}] calisiyor' -f $s[0],$s[1]) } else { Write-Host ('  {0} [:{1}] KAPALI' -f $s[0],$s[1]) } }"
echo ------------------------------------------
exit /b 0
