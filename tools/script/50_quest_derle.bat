@echo off
title work1 - quest derle
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
cd /d "%QUESTDIR%"

if not exist qc.exe ( echo [HATA] qc.exe yok - once ninja derleme (51) & exit /b 1 )
if not exist quest_list ( echo [HATA] quest_list yok & exit /b 1 )

setlocal EnableDelayedExpansion
set OK=0 & set HATA=0
for /f "delims=" %%f in (quest_list) do (
  qc.exe "%%f" >nul 2>&1
  if errorlevel 1 ( set /a HATA+=1 & echo [HATA] %%f ) else ( set /a OK+=1 )
)
echo ------------------------------------------
echo derlenen: %OK%   hata: %HATA%
if %HATA% GTR 0 exit /b 1
echo [OK] tum questler derlendi
