Get-WinEvent -ListLog "Microsoft-Windows-PowerShell/Operational" -Force -ErrorAction SilentlyContinue|
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
