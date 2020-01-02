$Begin = Get-Date -Date '5/20/2019 08:00:00'
$End = Get-Date -Date '5/21/2019 17:00:00'
Get-EventLog -LogName System -EntryType Error -After $Begin -Before $End

