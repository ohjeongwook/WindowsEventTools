Get-WinEvent -Path $args[0] -Force -ErrorAction SilentlyContinue -Oldest |
Format-List *