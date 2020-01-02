$LogName = "Microsoft-Windows-Sysmon/Operational"

$allLogs = Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue

$LogName | ForEach-Object -Process {
    $log = $wineventlog = $null
    $log = $_

    # Get rich object that maps the logname
    # $wineventlog is type of System.Diagnostics.Eventing.Reader.EventLogConfiguration
    # https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.eventing.reader.eventlogconfiguration?view=netframework-4.8

    $wineventlog = $allLogs | Where { $_.LogName -EQ $log}
        
    if ($wineventlog) {
        if ($wineventlog.isClassicLog) {
            Write-Warning "Cannot enable classic log: $_"
        } else {
            try {
                Write-Host "LogName:$Tab$Tab" $wineventlog.LogName
                Write-Host "IsEanbled:$Tab$Tab" $wineventlog.IsEanbled
                Write-Host "LogMode:$Tab$Tab" $wineventlog.LogMode
                Write-Host "MaximumSizeInBytes:$Tab" $wineventlog.MaximumSizeInBytes
                Write-Host "LogFilePath:$Tab$Tab" $wineventlog.LogFilePath
                Write-Host "LogType:$Tab$Tab" $wineventlog.LogType

                $wineventlog.MaximumSizeInBytes = 1024*1024*1024*2 # 2GB
                $wineventlog.SaveChanges()
                Write-Verbose -Message "Successfully increased log size $($wineventlog.logname)"  
            } catch {
                Write-Warning -Message "Failed to increased log size of $($wineventlog.logname) because $($_.Exception.Message)"
            }        
        }
    }
}

Get-WinEvent -ListLog "Microsoft-Windows-Sysmon/Operational" -Force -ErrorAction SilentlyContinue |
Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
