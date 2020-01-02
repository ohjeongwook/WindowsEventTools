$A = Get-EventLog -LogName System -Newest 100
$A | Select-Object -Property *