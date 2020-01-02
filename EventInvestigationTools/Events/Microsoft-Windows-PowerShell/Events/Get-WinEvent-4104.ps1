Get-WinEvent -FilterHashTable @{LogName='Microsoft-Windows-PowerShell/Operational';ID='4104'} |
Format-List  TimeCreated, Id, LevelDisplayName, Message