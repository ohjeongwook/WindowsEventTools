@echo off
:: W7 version

REM stop the current trace used by the diagtrack service
logman.exe stop  "Diagtrack-Listener" -ets

REM stop and disable the diagtrack service
net.exe stop diagtrack && sc.exe config diagtrack start= disabled

REM Stop the Autologger trace session
logman.exe stop  "AutoLogger-Diagtrack-Listener" -ets

REM Disable the Autologger session at the next computer restart
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0x0 /f

REM Delete the etl file
del /F/Q "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"

REM Other idea: block the diagtrack service at firewall level
netsh.exe advfirewall firewall add rule name="Block DiagTrack" dir=out action=block service=diagtrack profile=any
