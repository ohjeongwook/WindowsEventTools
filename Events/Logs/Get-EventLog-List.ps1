Get-EventLog -List -ErrorAction SilentlyContinue 

Get-EventLog -List -ErrorAction SilentlyContinue | Format-Table Log, LogDisplayName, Container, OverflowAction, EnableRaisingEvents -ErrorAction SilentlyContinue
