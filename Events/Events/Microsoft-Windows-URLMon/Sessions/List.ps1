Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue | 
Where LogName -Match "URLMon" | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
