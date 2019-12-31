$session = Get-EtwTraceSession -Name "KernelProcessTrace" 

$session | Format-List *

$session |
ForEach-Object -Process {
	foreach($loggingModeName in $_.LoggingModeNames)
	{
		Write-Host "   " $loggingModeName
	}
}