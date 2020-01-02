$events = Get-WinEvent -LogName 'Microsoft-Windows-Kernel-Process/Analytic' -Oldest 
$events | Measure-Object -Line
$events | Select-Object -Last 10 | Format-Table Id, TimeCreated, OpCodeDisplayName, Message