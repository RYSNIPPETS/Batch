@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Run on the domain controller that holds the PDC emulator role.
set "peers=%~1"
if not defined peers set "peers=time-a-wwv.nist.gov,0x8 time-b-wwv.nist.gov,0x8"

w32tm.exe /config /manualpeerlist:"%peers%" /syncfromflags:manual /reliable:yes /update
if errorlevel 1 exit /b %errorlevel%

net.exe stop w32time
if errorlevel 1 exit /b %errorlevel%

net.exe start w32time
if errorlevel 1 exit /b %errorlevel%

w32tm.exe /resync /rediscover
exit /b %errorlevel%
