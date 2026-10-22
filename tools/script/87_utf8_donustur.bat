@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
call "%~dp0_ayar.bat"
set "RAPOR=%KOK%\tools\utf8_rapor.txt"
if /i "%~1"=="--dry" (
  python "%KOK%\tools\utf8_donustur.py" "%KOK%" --dry-run --rapor "%RAPOR%"
) else (
  python "%KOK%\tools\utf8_donustur.py" "%KOK%" --rapor "%RAPOR%"
)
echo [OK] utf8 donusum bitti - rapor: %RAPOR%
