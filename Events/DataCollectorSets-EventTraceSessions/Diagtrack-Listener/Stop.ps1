# Disable the DiagTrack service
Get-Service DiagTrack | 
Stop-Service -Verbose -PassThru | 
Set-Service -StartupType Disabled -Verbose

# Disable compattelrunner.exe launched by scheduled tasks
'Microsoft Compatibility Appraiser',
'ProgramDataUpdater' | ForEach-Object {
    Get-ScheduledTask -TaskName $_ -TaskPath '\Microsoft\Windows\Application Experience\' |
    Disable-ScheduledTask
}

# Stop and remove Diagtrack ETL trace session under
# C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\
Get-EtwTraceSession -Name * | 
Where Name -match '(AutoLogger-)?Diagtrack-Listener'|
Remove-EtwTraceSession

del C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl -ErrorAction SilentlyContinue

# Disable the Autologger session at the next computer restart
Set-AutologgerConfig -Name 'AutoLogger-Diagtrack-Listener' -Start 0

# Other idea: block the diagtrack service at firewall level
New-NetFirewallRule -Name "Block DiagTrack" -Profile Any -Direction Outbound -Action Block -Service DiagTrack -DisplayName "Block DiagTrack"