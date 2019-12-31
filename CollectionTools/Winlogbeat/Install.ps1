Stop-Service winlogbeat

Set-Location $PSScriptRoot
[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")
(New-Object System.Net.WebClient).DownloadFile("https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.1.1-windows-x86_64.zip", "$pwd\winlogbeat-7.1.1-windows-x86_64.zip")

Expand-Archive -path 'winlogbeat-7.1.1-windows-x86_64.zip' -destinationpath '.'
$destiNameFolder="$pwd\winlogbeat-7.1.1-windows-x86_64"

Copy-Item "winlogbeat.yml" -Destination $destiNameFolder -Force

Set-Location $destiNameFolder
. .\install-service-winlogbeat.ps1

Start-Service winlogbeat
Get-Service winlogbeat
