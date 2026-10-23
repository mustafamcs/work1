@echo off
title work1 - control center derle
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem work1-ControlCenter.exe'yi tools\control-center kaynaklarindan derler.
rem Dahili .NET 4 csc.exe kullanir (ayri bir SDK gerekmez).

set "SRCDIR=%KOK%\tools\control-center"
set "OUT=%KOK%\work1-ControlCenter.exe"
set "ICO=%KOK%\client\metin2.ico"
set "MANIFEST=%SRCDIR%\app.manifest"

set "CSC="
for %%F in (
  "%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
  "%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe"
) do if exist %%~F set "CSC=%%~F"

if not defined CSC ( echo [HATA] csc.exe bulunamadi & exit /b 1 )

rem calisan exe varsa kapat
taskkill /IM work1-ControlCenter.exe /F >nul 2>&1

"%CSC%" /nologo /target:winexe /optimize+ /out:"%OUT%" /win32icon:"%ICO%" /win32manifest:"%MANIFEST%" ^
  /r:System.dll /r:System.Core.dll /r:System.Drawing.dll /r:System.Windows.Forms.dll /r:System.Net.dll /r:System.ServiceProcess.dll ^
  "%SRCDIR%\Program.cs" ^
  "%SRCDIR%\Theme.cs" ^
  "%SRCDIR%\BackendService.cs" ^
  "%SRCDIR%\ControlCenterForm.cs" ^
  "%SRCDIR%\Pages\DashboardPage.cs" ^
  "%SRCDIR%\Pages\BuildPackPage.cs" ^
  "%SRCDIR%\Pages\SetupWizardPage.cs" ^
  "%SRCDIR%\Pages\DatabaseGmPage.cs" ^
  "%SRCDIR%\Pages\ConfigGitPage.cs"

if errorlevel 1 ( echo [HATA] control center derleme hatasi & exit /b 1 )
echo [OK] %OUT%
exit /b 0
