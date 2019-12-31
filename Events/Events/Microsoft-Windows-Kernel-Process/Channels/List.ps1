Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue| 
Where LogName -Match "Microsoft-Windows-Kernel-Process/Analytic" | 
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
