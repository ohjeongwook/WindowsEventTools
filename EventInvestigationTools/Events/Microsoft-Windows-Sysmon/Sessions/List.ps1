Get-WinEvent -ListLog "Microsoft-Windows-Sysmon/Operational" -Force -ErrorAction SilentlyContinue |
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
