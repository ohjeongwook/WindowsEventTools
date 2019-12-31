param (
    [datetime]$start_date = (Get-Date).AddMinutes(-10),
    [datetime]$end_date = (Get-Date)
)

Write-Host "Enumerating Microsoft-Windows-Sysmon/Operational events from " $start_date " to " $end_date
$events = Get-WinEvent -FilterHashTable @{ LogName = "Microsoft-Windows-Sysmon/Operational"; StartTime = $start_date; EndTime = $end_date}

Write-Host $events

Write-Host "Couting totals"
$events | Measure-Object -Line

Write-Host "Sort By Count"
$events | Group-Object -Property Id -NoElement | Sort-Object -Property Count -Descending

Write-Host "Group By LevelDisplayName"
$events | Group-Object -Property LevelDisplayName -NoElement
