Get-WinEvent -ListLog "Applocker*" -Force -ErrorAction SilentlyContinue| 
Enable-WinEvent -Passthru | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
