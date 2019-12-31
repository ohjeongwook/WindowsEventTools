WevtUtil qe "Windows PowerShell" /rd:true
WevtUtil qe "Windows PowerShell" /q:"*[System[(EventID=500)]]" /c:5 /rd:true /f:text
WevtUtil qe "Windows PowerShell" /q:"*[System[(EventID=501)]]" /c:1000 /rd:true /f:text 
WevtUtil qe "Microsoft-Windows-PowerShell/Operational" /q:"*[System[(EventID=4104)]]" /c:1000 /rd:true /f:text