@echo off
setlocal EnableExtensions DisableDelayedExpansion

if /I "%~1"=="guid" goto :guid
if /I "%~1"=="scan" goto :scan
if /I "%~1"=="remove" goto :remove
goto :usage

:guid
if "%~2"=="" goto :usage
dsquery.exe * "%~2" -scope base -attr objectGUID
exit /b %errorlevel%

:scan
if "%~4"=="" goto :usage
repadmin.exe /removelingeringobjects "%~2" "%~3" "%~4" /advisory_mode
exit /b %errorlevel%

:remove
if "%~4"=="" goto :usage
if /I not "%~5"=="/force" goto :usage
repadmin.exe /removelingeringobjects "%~2" "%~3" "%~4"
exit /b %errorlevel%

:usage
echo Usage:
echo   %~nx0 guid "CN=DC01,OU=Domain Controllers,DC=example,DC=com"
echo   %~nx0 scan ^<destination-DC^> ^<source-DSA-GUID^> ^<naming-context^>
echo   %~nx0 remove ^<destination-DC^> ^<source-DSA-GUID^> ^<naming-context^> /force
echo.
echo Always run scan first. The source DSA must contain an authoritative,
echo writable copy of the naming context.
exit /b 2
