param([int]$port, [int]$timeoutSn = 15)
# Port dinlenene dek 100ms araliklarla bekler. Cikis kodu: 0 acildi, 1 zaman asimi.
$t = [Diagnostics.Stopwatch]::StartNew()
while ($t.Elapsed.TotalSeconds -lt $timeoutSn) {
    if (Get-NetTCPConnection -State Listen -LocalPort $port -ErrorAction SilentlyContinue) { exit 0 }
    Start-Sleep -Milliseconds 100
}
exit 1
