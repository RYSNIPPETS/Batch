@echo off
setlocal EnableExtensions DisableDelayedExpansion

if /I "%~1"=="domain" goto :run
if /I "%~1"=="dc" goto :run
if /I "%~1"=="both" goto :run
goto :usage

:run
dcgpofix.exe /target:%~1
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<domain^|dc^|both^>
echo This resets the selected default GPO to its original settings.
exit /b 2
