@echo off
title work1 - degisen paketleri repack
call "%~dp0_ayar.bat"
net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)
rem Srcs\Pack altindaki her dizinin en yeni dosya zamani ile
rem client\pack\<ad>.epk karsilastirilir; sadece guncel olmayanlar repack edilir.
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "$src='%SRCSPACK%'; $pk='%PACKDIR%';" ^
 "$degisen=@();" ^
 "Get-ChildItem $src -Directory | ForEach-Object {" ^
 "  $epk=Join-Path $pk ($_.Name+'.epk');" ^
 "  $son=(Get-ChildItem $_.FullName -Recurse -File | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime;" ^
 "  if (-not (Test-Path $epk) -or (Get-Item $epk).LastWriteTime -lt $son) { $degisen+=$_.Name }" ^
 "}; $degisen -join ' ' | Set-Content -Encoding ascii '%TEMP%\work1_paketler.txt'"
set /p DEGISEN=<"%TEMP%\work1_paketler.txt"
if "%DEGISEN%"=="" ( echo [OK] tum paketler guncel & exit /b 0 )
echo repack edilecek: %DEGISEN%
for %%P in (%DEGISEN%) do (
  call "%~dp071_paket_repack.bat" "%%P" || exit /b 1
)
echo [OK] guncelleme bitti
exit /b 0
