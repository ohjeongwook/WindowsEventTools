Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue |
Format-List -Property *
# LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
