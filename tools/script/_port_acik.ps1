param([int]$port)
# Port dinleniyorsa 0, degilse 1. Anlik (~30ms), netstat taramasi yok.
if (Get-NetTCPConnection -State Listen -LocalPort $port -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }
