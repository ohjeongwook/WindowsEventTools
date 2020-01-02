$AMSIScanEvents = Get-WinEvent -Path $args[0] -Oldest |
ForEach-Object {
        Write-Host "TimeCreated: " $_.TimeCreated
        Write-Host "ProcessId: " $_.ProcessId
        $keywordsHex = '{0:x}' -f $_.Keywords
        Write-Host "Keywords: " $keywordsHex
        
        foreach ($property in $_.Properties) {
                Write-Host "    " $property.Value
        }

        Write-Host ""
}