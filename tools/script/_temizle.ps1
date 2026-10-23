param([string]$kok, [string]$scriptdir)
# 82_temizle.bat icin temizleyici.
# Runtime loglari aninda; repo-geneli artik taramasi cmd'nin yerel del/rd'sine devredildi (hizli).
$srv = Join-Path $kok 'server'
$cli = Join-Path $kok 'client'

$dosyalar = 'syserr.txt','syserr','syslog.txt','syslog','stdout.txt','stdout','PTS.txt','usage.txt'
Get-ChildItem -Path $srv -Recurse -File -Include $dosyalar -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path $cli -File -Include $dosyalar -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

if (Test-Path "$srv\logs") { Remove-Item "$srv\logs" -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path "$cli\logs") { Get-ChildItem "$cli\logs" -File | Remove-Item -Force -ErrorAction SilentlyContinue }
if (Test-Path "$scriptdir\log") { Get-ChildItem "$scriptdir\log" -File | Remove-Item -Force -ErrorAction SilentlyContinue }
