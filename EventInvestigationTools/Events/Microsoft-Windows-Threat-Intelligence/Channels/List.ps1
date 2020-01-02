Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue | 
Where LogName -Match "Microsoft-Windows-Threat-Intelligence" | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
