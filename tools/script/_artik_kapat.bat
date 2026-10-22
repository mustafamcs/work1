@echo off

rem ayni oturumdaki arac prosesleri icin admin gerekmez;
rem yabancı oturum prosesi varsa taskkill sessizce hata verir (sorun degil)
rem _artik_kapat.bat - islem sonunda arka planda kalan gereksiz
rem surecleri kapatir. Oyun sureclerine (db/game/mariadbd/istemci)
rem DOKUNMAZ - sadece derleme ve arac artiklari.

for %%P in (
  MSBuild.exe MSBuildTaskHost.exe
  cl.exe link.exe mspdbsrv.exe cvtres.exe rc.exe
  VBCSCompiler.exe vctip.exe tracker.exe
  PackMakerLite.exe DumpProto.exe
) do taskkill /IM %%P /F >nul 2>&1
exit /b 0
