@echo off
title work1 - dpdll build
call "%~dp0_ayar.bat"

net session >nul 2>&1
if %errorlevel% neq 0 (
  cscript //nologo "%~dp0_admin.vbs" "%~f0" %*
  exit /b
)

set "VS2022=C:\Program Files\Microsoft Visual Studio\2022\Community"
set "VCVARS=%VS2022%\VC\Auxiliary\Build\vcvars32.bat"
if not exist "%VCVARS%" ( echo [HATA] vcvars32 bulunamadi: %VCVARS% & exit /b 1 )

call "%VCVARS%" >nul 2>&1

set "SRC=%KOK%\tools\dpdll\dpdll.c"
set "OUT=%KOK%\client\dpdll.dll"

cl /nologo /LD /MT /O2 /W3 "%SRC%" /link /OUT:"%OUT%" /NODEFAULTLIB:msvcrt >nul
if errorlevel 1 ( echo [HATA] dpdll derleme basarisiz & exit /b 1 )

powershell -nologo -noprofile -command ^
  "$fs=[IO.File]::ReadAllBytes('%OUT%');" ^
  "$t=New-Object 'uint32[]' 256;" ^
  "for($i=0;$i -lt 256;$i++){$c=[uint32]$i;for($k=0;$k -lt 8;$k++){if($c -band 1){$c=0xEDB88320 -bxor ($c -shr 1)}else{$c=$c -shr 1}};$t[$i]=$c};" ^
  "$crc=[uint32]0xFFFFFFFF;" ^
  "foreach($b in $fs){$crc=$t[($crc -bxor $b) -band 0xFF] -bxor ($crc -shr 8)};" ^
  "$crc=$crc -bxor 0xFFFFFFFF;" ^
  "Write-Output ('CRC32=0x{0:X8} SIZE={1}' -f $crc, $fs.Length)" > "%TEMP%\dpdll_sig.txt"

type "%TEMP%\dpdll_sig.txt"
echo [OK] dpdll.dll -^> %OUT%
