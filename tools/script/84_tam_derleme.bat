@echo off
title work1 - sifirdan tam derleme
call "%~dp0_ayar.bat"
rem out\ dizinini komple siler, Metin2.sln'in TUM projelerini
rem (client lib'leri + UserInterface + server + tools) derler,
rem sonra ciktilari kullanildiklari dizinlere dagitir.

echo == 1/4 acik surecler kapatiliyor ==
call "%~dp031_hepsini_durdur.bat" >nul
taskkill /IM metin2client.exe /F >nul 2>&1
taskkill /IM qc.exe /F >nul 2>&1

echo == 2/4 out dizini siliniyor ==
if exist "%KOK%\out" rd /s /q "%KOK%\out"

echo == 3/4 tum cozum derleniyor (Release|Win32) ==
"%MSBUILD%" "%SLN_CLIENT%" /t:Rebuild /p:Configuration=Release /p:Platform=Win32 /m /nologo /v:m
if errorlevel 1 ( echo [HATA] derleme basarisiz & exit /b 1 )

echo == 4/4 ciktilar dagitiliyor ==
set "OUT=%KOK%\out"
copy /y "%OUT%\db\Release\db.exe"            "%SRV%\db\"        >nul
copy /y "%OUT%\db\Release\db.exe"            "%SRV%\share\bin\" >nul
for %%D in (auth channel1\core1 channel99 share\bin) do (
  copy /y "%OUT%\game\Release\game.exe" "%SRV%\%%D\" >nul
)
for %%D in ("%QUESTDIR%" "%SRV%\share\bin") do (
  copy /y "%OUT%\qc\Release\qc.exe" "%%~D\" >nul
)
copy /y "%OUT%\client\UserInterface\Release\bin\metin2client.exe" "%CLIENTDIR%\" >nul

echo.
echo [OK] tam derleme + dagitim bitti
exit /b 0
