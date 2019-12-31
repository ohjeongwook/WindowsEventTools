Get-EventLog -LogName Application -Source Outlook | Where-Object {$_.EventID -eq 63} | Select-Object -Property Source, EventID, InstanceId, Message

