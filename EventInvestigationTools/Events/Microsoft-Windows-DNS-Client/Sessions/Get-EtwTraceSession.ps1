Get-EtwTraceSession -Name "EventLog-Application" |
ForEach-Object -Process {
	Write-Host "Name: " $_.Name
	foreach($loggingModeName in $_.LoggingModeNames)
	{
		Write-Host "   " $loggingModeName
	}
}