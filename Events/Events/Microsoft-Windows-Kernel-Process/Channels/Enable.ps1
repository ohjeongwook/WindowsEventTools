. ..\..\..\Tools\WinEvent.ps1

$event = Get-WinEvent -ListLog "Microsoft-Windows-Kernel-Process/Analytic" -Force 
# -ErrorAction SilentlyContinue
$event | Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize

$wineventlog = $event | Where { $_.LogName -EQ "Microsoft-Windows-Kernel-Process/Analytic"}

$wineventlog.LogMode = [System.Diagnostics.Eventing.Reader.EventLogMode]::Circular
$wineventlog.set_IsEnabled($true)
# | Out-Null
$wineventlog.SaveChanges()

# $event|
#Enable-WinEvent -Passthru | 
#Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
