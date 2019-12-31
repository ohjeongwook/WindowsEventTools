echo List settings of the PowerShell Log
WevtUtil gl "Windows PowerShell"

echo Set the PowerShell Log size to the number of bytes
WevtUtil sl "Windows PowerShell" /ms:512000000

echo Overwrite as needed
WevtUtil sl "Windows PowerShell" /rt:false

echo List settings of the PowerShell Log
WevtUtil gl "Microsoft-Windows-PowerShell/Operational"

WevtUtil sl "Microsoft-Windows-PowerShell/Operational" /ms:512000000

echo Overwrite as needed
WevtUtil sl "Microsoft-Windows-PowerShell/Operational" /rt:false
