@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
if /I "%~2"=="inbound" set "replication_option=DISABLE_INBOUND_REPL"
if /I "%~2"=="outbound" set "replication_option=DISABLE_OUTBOUND_REPL"
if not defined replication_option goto :usage

if /I "%~3"=="disable" set "change=+%replication_option%"
if /I "%~3"=="enable" set "change=-%replication_option%"
if not defined change goto :usage

repadmin.exe /options "%~1" %change%
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<domain-controller^> ^<inbound^|outbound^> ^<enable^|disable^>
exit /b 2
