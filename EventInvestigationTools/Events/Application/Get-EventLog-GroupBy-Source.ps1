$Events = Get-EventLog -LogName Application
$Events | Group-Object -Property Source -NoElement | Sort-Object -Property Count -Descending
