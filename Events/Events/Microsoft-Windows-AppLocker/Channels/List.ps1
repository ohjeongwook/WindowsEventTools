Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue| 
Where LogName -Match "Applocker" | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
