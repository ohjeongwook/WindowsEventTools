pushd %~dp0
sysmon -accepteula -h md5,sha256 -n -c sysmonconfig.xml 
pause