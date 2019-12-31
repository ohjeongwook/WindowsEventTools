$A = Get-EventLog -LogName URLMon -Newest 100
$A | Select-Object -Property *