$A = Get-EventLog -LogName WinINet -Newest 100
$A | Select-Object -Property *