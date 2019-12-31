pushd %~dp0
sysmon -accepteula -h md5,sha256 -n -i sysmonconfig.xml 
pause