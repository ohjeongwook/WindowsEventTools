Get-WinEvent -LogName 'Microsoft-Windows-Kernel-Process/Analytic' -Oldest | Format-Table Id, TimeCreated, OpCodeDisplayName, Message
