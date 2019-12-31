Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue| 
Where LogName -Match "DNS" | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
