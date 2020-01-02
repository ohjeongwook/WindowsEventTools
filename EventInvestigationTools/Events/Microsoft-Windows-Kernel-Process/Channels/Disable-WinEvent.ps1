. "$PSScriptRoot\..\..\..\Tools\WinEvent.ps1"

Get-WinEvent -ListLog "Microsoft-Windows-Kernel-Process/Analytic" -Force -ErrorAction SilentlyContinue|
Disable-WinEvent -Passthru | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
