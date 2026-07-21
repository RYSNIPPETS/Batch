@echo off
setlocal EnableExtensions DisableDelayedExpansion

if /I "%~1"=="create" goto :create
if /I "%~1"=="list" goto :list
if /I "%~1"=="mount" goto :mount
if /I "%~1"=="expose" goto :expose
goto :usage

:create
ntdsutil.exe "activate instance ntds" snapshot create quit quit
exit /b %errorlevel%

:list
ntdsutil.exe "activate instance ntds" snapshot "list all" quit quit
exit /b %errorlevel%

:mount
if "%~2"=="" goto :usage
ntdsutil.exe "activate instance ntds" snapshot "mount %~2" quit quit
exit /b %errorlevel%

:expose
if "%~3"=="" goto :usage
set "ldap_port=%~3"
for /f "delims=0123456789" %%A in ("%ldap_port%") do goto :usage
dsamain.exe -dbpath "%~2" -ldapport %ldap_port%
exit /b %errorlevel%

:usage
echo Usage:
echo   %~nx0 create
echo   %~nx0 list
echo   %~nx0 mount ^<snapshot-GUID^>
echo   %~nx0 expose ^<snapshot-ntds.dit-path^> ^<LDAP-port^>
exit /b 2
