#Requires -version 2.0

Function Enum-WinEvent  {
    <#
        .SYNOPSIS
            Enable event logs by name
        
        .DESCRIPTION
            Enable event logs by their exact full name
         
        .PARAMETER PassThru
            Switch to allow System.Diagnostics.Eventing.Reader.EventLogConfiguration objects to flow into the pipeline
         
        .PARAMETER LogName
            Array of eventlog names
         
        .EXAMPLE
            
         
        .EXAMPLE
            
     
        .EXAMPLE
            Enum-WinEvent     
        .NOTES
            You cannot enable or disable a classic log. A warning will be issued if you do.
    #>
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$false,ValueFromPipeLine=$true,ValueFromPipelineByPropertyName=$true)]
        [Alias('Log')]
        [system.string[]]$LogName
    )
    Begin{
        $allLogs = Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue
    }
    Process {
        $LogName | ForEach-Object -Process {
            $log = $wineventlog = $null
            $log = $_
            # Get rich object that maps the logname
            # $wineventlog is type of System.Diagnostics.Eventing.Reader.EventLogConfiguration
            foreach($wineventlog in $allLogs)
            { 
                if ($wineventlog) {
                    Write-Host $wineventlog.LogName
                    Write-Host $wineventlog.LogFilePath
                    Write-Host ""
                } else {
                    Write-Warning "Cannot find a log named $_"
                }
            }
        }
    }
    End {}
}

Function Enable-WinEvent  {
<#
    .SYNOPSIS
        Enable event logs by name
    
    .DESCRIPTION
        Enable event logs by their exact full name
     
    .PARAMETER PassThru
        Switch to allow System.Diagnostics.Eventing.Reader.EventLogConfiguration objects to flow into the pipeline
     
    .PARAMETER LogName
        Array of eventlog names
     
    .EXAMPLE
        Enable-WinEvent -LogName "Microsoft-Windows-AppLocker/EXE and DLL","Microsoft-Windows-AppLocker/MSI and Script" -PassThru
     
    .EXAMPLE
        Get-WinEvent -ListLog * | Where {$_.LogName -Match "Applocker" } | Enable-WinEvent -Verbose
 
    .EXAMPLE
        Get-WinEvent -ListLog * | 
        Where {$_.LogName -Match "Applocker" } | 
        Enable-WinEvent -Passthru | 
        Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
 
    .NOTES
        You cannot enable or disable a classic log. A warning will be issued if you do.
#>
[cmdletbinding()]
Param(
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true,ValueFromPipelineByPropertyName=$true)]
    [Alias('Log')]
    [system.string[]]$LogName,
    [Switch]$Passthru
)
Begin{
    $allLogs = Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue
}
Process {
    $LogName | ForEach-Object -Process {
        $log = $wineventlog = $null
        $log = $_
        # Get rich object that maps the logname
        # $wineventlog is type of System.Diagnostics.Eventing.Reader.EventLogConfiguration
        $wineventlog = $allLogs | Where { $_.LogName -EQ $log}
         
        if ($wineventlog) {
            if ($wineventlog.isClassicLog) {
                Write-Warning "Cannot enable classic log: $_"
            } else {
                try {
                    Write-Host "Enabling" $wineventlog.LogName, $wineventlog.IsEanbled, $wineventlog.LogMode
                    $wineventlog.set_IsEnabled($true) | Out-Null
                    $wineventlog.SaveChanges()
                    Write-Verbose -Message "Successfully enabled log $($wineventlog.logname)"   
                    if ($Passthru) { $wineventlog }
                } catch {
                    Write-Warning -Message "Failed to enable $($wineventlog.logname) because $($_.Exception.Message)"
                }        
            }
        } else {
            Write-Warning "Cannot find a log named $_"
        }
    }
}
End {}
}
 
Function Disable-WinEvent  {
<#
    .SYNOPSIS
        Disable event logs by name
    
    .DESCRIPTION
        Disable event logs by their exact full name
     
    .PARAMETER PassThru
        Switch to allow System.Diagnostics.Eventing.Reader.EventLogConfiguration objects to flow into the pipeline
     
    .PARAMETER LogName
        Array of eventlog names
     
    .EXAMPLE
        Disable-WinEvent -LogName "Microsoft-Windows-AppLocker/EXE and DLL","Microsoft-Windows-AppLocker/MSI and Script" -PassThru
     
    .EXAMPLE
        Get-WinEvent -ListLog * | Where {$_.LogName -Match "Applocker" } | Disable-WinEvent -Verbose
 
    .EXAMPLE
        Get-WinEvent -ListLog * | 
        Where {$_.LogName -Match "Applocker" } | 
        Disable-WinEvent -Passthru | 
        Format-Table -Property LogMode,MaximumSizeInBytes,RecordCount,LogName,isEnabled -AutoSize
 
    .NOTES
        You cannot enable or disable a classic log. A warning will be issued if you do.
#>
 
[cmdletbinding()]
Param(
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true,ValueFromPipelineByPropertyName=$true)]
    [Alias('Log')]
    [system.string[]]$LogName,
    [Switch]$Passthru
)
Begin{
    $allLogs = Get-WinEvent -ListLog * -Force -ErrorAction SilentlyContinue
}
Process {
    $LogName | ForEach-Object -Process {
        $log = $wineventlog = $null
        $log = $_
        # Get rich object that maps the logname
        $wineventlog = $allLogs | Where { $_.LogName -EQ $log}
         
        if ($wineventlog) {
            if ($wineventlog.isClassicLog) {
                Write-Warning "Cannot disable classic log: $_"
            } else {
                try {
                    $wineventlog.set_IsEnabled($false) | Out-Null
                    $wineventlog.SaveChanges()
                    Write-Verbose -Message "Successfully disabled log $($wineventlog.logname)"
                    if ($Passthru) { $wineventlog }
                } catch {
                    Write-Warning -Message "Failed to enable $($wineventlog.logname) because $($_.Exception.Message)"
                }        
            }
        } else {
            Write-Warning "Cannot find a log named $log"
        }
    }
}
End {}
}