Write-Host "Getting top five processes by CPU locally"
Get-Process | Sort CPU -descending | Select -first 5 -Property ID,ProcessName,CPU | format-table -autosize

Write-Host "Selecting by TotalProcessorTime"
Get-Process | Sort TotalProcessorTime -descending | Select -first 5 -Property ID,ProcessName,TotalProcessorTime | format-table -autosize
