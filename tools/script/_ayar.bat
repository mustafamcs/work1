@echo off
rem ============================================================
rem  _ayar.bat - tum betiklerin paylastigi ortak ayarlar.
rem  Yeni makine/paths icin sadece bu dosyayi duzenle.
rem ============================================================

set "KOK=%~dp0..\.."
set "SRV=%KOK%\server"

rem --- derleme ---
set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
set "SLN=%KOK%\Srcs\Server\server.sln"
set "SLN_CLIENT=%KOK%\Srcs\Metin2.sln"

rem --- diger ---
set "QUESTDIR=%SRV%\share\locale\turkey\quest"
set "PACKDIR=%KOK%\client\pack"
set "SRCSPACK=%KOK%\Srcs\Pack"
set "CLIENTDIR=%KOK%\client"

rem --- MariaDB (hizmet yerine dogrudan surec olarak calistirilir) ---
set "MARIADB_EXE=C:\GitHub\valiant2\runtime\dependencies\mariadb\bin\mariadbd.exe"
set "MARIADB_INI=C:\GitHub\valiant2\runtime\dependencies\mariadb\data\my.ini"
set "MYSQLADMIN=C:\GitHub\valiant2\runtime\dependencies\mariadb\bin\mysqladmin.exe"
set "MYSQL_BIN=C:\GitHub\valiant2\runtime\dependencies\mariadb\bin\mysql.exe"
set "MYSQL_USER=work1"
set "MYSQL_PASS=7441b621324e2f4d6be6bdc6"
