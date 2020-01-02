$session = Get-EtwTraceSession -Name "Diagtrack-Listener" 

$session | Format-List *

$session |
ForEach-Object -Process {
	foreach($loggingModeName in $_.LoggingModeNames)
	{
		Write-Host "   " $loggingModeName
	}
}