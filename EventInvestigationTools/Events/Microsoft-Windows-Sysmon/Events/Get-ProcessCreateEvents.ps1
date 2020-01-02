param (
    [datetime]$start_date = (Get-Date).AddDays(-1),
    [datetime]$end_date = (Get-Date)
 )

Write-Host "Querying " $start_date " to " $end_date
$events = Get-WinEvent -FilterHashTable @{ LogName = "Microsoft-Windows-Sysmon/Operational"; StartTime = $start_date; EndTime = $end_date; ID = 1 } 
$events | Format-List  TimeCreated, Id, LevelDisplayName, Message