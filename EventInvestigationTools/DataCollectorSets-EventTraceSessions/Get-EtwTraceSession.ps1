$session = Get-EtwTraceSession -Name $args[0]

$session | Format-List *

$session |
ForEach-Object -Process {
	foreach($loggingModeName in $_.LoggingModeNames)
	{
		Write-Host "   " $loggingModeName
	}
}