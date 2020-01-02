param (
    [datetime]$start_date = (Get-Date).AddMinutes(-70),
    [datetime]$end_date = (Get-Date).AddMinutes(-10)
)

$filter = @{}
$filter.Add("LogName", "Microsoft-Windows-Sysmon/Operational")
$filter.Add("StartTime", $start_date)
$filter.Add("EndTime", $end_date)

Write-Host "Querying Microsoft-Windows-Sysmon/Operational events from " $start_date " to " $end_date
Get-WinEvent -FilterHashTable $filter | Format-List  TimeCreated, Id, LevelDisplayName, Message -outvariable events
$events | Export-Clixml -Path  "WinEvents.xml"