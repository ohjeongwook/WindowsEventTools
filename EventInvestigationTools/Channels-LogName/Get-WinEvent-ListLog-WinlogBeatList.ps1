Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue |
ForEach-Object -Process {Write-Host "  - name: " $_.LogName}
