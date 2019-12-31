Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue | 
Where LogName -Match "WinINet" | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
