# -LocalFilePath c:\KernelProcess.etl 
# Old: 0x18800180
# New: 0x08800110
#New-EtwTraceSession -Name "KernelProcessTrace" -LogFileMode 0x08800110
#New-EtwTraceSession -AutologgerName "KernelProcessTrace" -LogFileMode 0x08800110


Add-EtwTraceProvider -Guid '{22FB2CD6-0E7B-422B-A0C7-2FAD1FD0E716}' -MatchAnyKeyword 0x0000000000000040 -MatchAllKeyword 0x0  -SessionName "KernelProcessTrace" -Property 0x381
Start-EtwTraceSession -Name "KernelProcessTrace" -LogFileMode 0x08800110

# . .\Enable-WinEvent.ps1
# Stop-EtwTraceSession -Name 'EventLog-Microsoft-Windows-Kernel-Process-Analytic'
# Remove-EtwTraceProvider -Guid '{22FB2CD6-0E7B-422B-A0C7-2FAD1FD0E716}' -SessionName 'EventLog-Microsoft-Windows-Kernel-Process-Analytic'