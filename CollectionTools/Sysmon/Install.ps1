Set-Location -Path $PSScriptRoot
(New-Object System.Net.WebClient).DownloadFile("https://download.sysinternals.com/files/Sysmon.zip", "$pwd\Sysmon.zip")
Expand-Archive -path 'Sysmon.zip' -destinationpath '.'
Start-Process "Sysmon.exe" "-accepteula -h md5,sha256 -n -i sysmonconfig.xml"

. .\Set-LogSize.ps1
