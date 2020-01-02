$log = Get-WinEvent -ListLog 'Application'
$log.LogMode = [System.Diagnostics.Eventing.Reader.EventLogMode]::Circular
$log.SaveChanges()