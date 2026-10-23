@echo off
title work1 - data/syserr duzeltme
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

rem %1 olarak --dry verilirse sadece raporlar, yazmaz
python "%~dp0data_duzelt.py" "%KOK%" %*
if errorlevel 1 ( echo [HATA] data duzeltme basarisiz & exit /b 1 )

rem --- canli sema esitleme: item.window'a PET ekle (schema.sql ile ayni sira, sona) ---
if exist "%MYSQL_BIN%" (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0_port_acik.ps1" 3306 >nul 2>&1
  if not errorlevel 1 (
    "%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% -e "ALTER TABLE player.item MODIFY COLUMN `window` enum('INVENTORY','EQUIPMENT','SAFEBOX','MALL','DRAGON_SOUL_INVENTORY','BELT_INVENTORY','GROUND','IKASHOP_OFFLINESHOP','IKASHOP_SAFEBOX','IKASHOP_AUCTION','COSTUME','ACCE','AURA','TALISMAN','PET') NOT NULL;" 2>nul
    if not errorlevel 1 ( echo [OK] item.window enum schema.sql ile esitlendi ) else ( echo [BILGI] item.window alter atlandi )
  ) else (
    echo [BILGI] mariadb kapali - item.window alter atlandi
  )
)
exit /b 0
