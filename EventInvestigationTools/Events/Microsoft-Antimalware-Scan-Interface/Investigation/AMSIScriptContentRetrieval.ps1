# Script author: Matt Graeber (@mattifestation)
# logman start AMSITrace -p Microsoft-Antimalware-Scan-Interface Event1 -o AMSITrace.etl -ets
# Do your malicious things here that would be logged by AMSI
# logman stop AMSITrace -ets

$OSArchProperty = Get-CimInstance -ClassName Win32_OperatingSystem -Property OSArchitecture
$OSArch = $OSArchProperty.OSArchitecture

$OSPointerSize = 32
if ($OSArch -eq '64-bit') { $OSPointerSize = 64 }

$AMSIScanEvents = Get-WinEvent -Path .\AMSITrace.etl -Oldest -FilterXPath '*[System[EventID=1101]]' | ForEach-Object {
    if (-not $_.Properties) {
        # The AMSI provider is not supplying the contentname property when WSH content is logged resulting
        # in Get-WinEvent or Event Viewer being unable to parse the data based on the schema.
        # If this bug were not present, retrieving WSH content would be trivial.

        $PayloadString = ([Xml] $_.ToXml()).Event.ProcessingErrorData.EventPayload
        [Byte[]] $PayloadBytes = ($PayloadString -split '([0-9A-F]{2})' | Where-Object {$_} | ForEach-Object {[Byte] "0x$_"})

        $MemoryStream = New-Object -TypeName IO.MemoryStream -ArgumentList @(,$PayloadBytes)
        $BinaryReader = New-Object -TypeName IO.BinaryReader -ArgumentList $MemoryStream, ([Text.Encoding]::Unicode)

        switch ($OSPointerSize) {
            32 { $Session = $BinaryReader.ReadUInt32() }
            64 { $Session = $BinaryReader.ReadUInt64() }
        }

        $ScanStatus = $BinaryReader.ReadByte()
        $ScanResult = $BinaryReader.ReadInt32()

        $StringBuilder = New-Object -TypeName Text.StringBuilder
        do { $CharVal = $BinaryReader.ReadInt16(); $null = $StringBuilder.Append([Char] $CharVal) } while ($CharVal -ne 0)
        $AppName = $StringBuilder.ToString()
        $null = $StringBuilder.Clear()

        $ContentSize = $BinaryReader.ReadInt32()
        $OriginalSize = $BinaryReader.ReadInt32()
        $ContentRaw = $BinaryReader.ReadBytes($ContentSize)
        $Content = [Text.Encoding]::Unicode.GetString($ContentRaw)
        $Hash = [BitConverter]::ToString($BinaryReader.ReadBytes(0x20)).Replace('-', '')
        [Bool] $ContentFiltered = $BinaryReader.ReadInt32()

        $BinaryReader.Close()

        [PSCustomObject] @{
            Session = $Session
            ScanStatus = $ScanStatus
            ScanResult = $ScanResult
            AppName = $AppName
            ContentName = $null
            Content = $Content
            Hash = $Hash
            ContentFiltered = $ContentFiltered
        }
    } else {
        $Session = $_.Properties[0].Value
        $ScanStatus = $_.Properties[1].Value
        $ScanResult = $_.Properties[2].Value
        $AppName = $_.Properties[3].Value
        $ContentName = $_.Properties[4].Value
        $Content = [Text.Encoding]::Unicode.GetString($_.Properties[7].Value)
        $Hash = [BitConverter]::ToString($_.Properties[8].Value).Replace('-', '')
        $ContentFiltered = $_.Properties[9].Value

        [PSCustomObject] @{
            Session = $Session
            ScanStatus = $ScanStatus
            ScanResult = $ScanResult
            AppName = $AppName
            ContentName = $ContentName
            Content = $Content
            Hash = $Hash
            ContentFiltered = $ContentFiltered
        }
    }
}

$AMSIScanEvents