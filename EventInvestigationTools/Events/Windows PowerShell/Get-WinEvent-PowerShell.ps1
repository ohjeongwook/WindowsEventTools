Write-Host "Enumerating Windows PowerShell events"
$Event = Get-WinEvent -LogName 'Windows PowerShell' -MaxEvent 1000
$Event