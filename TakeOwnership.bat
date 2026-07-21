@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
if /I not "%~2"=="/force" goto :usage
set "target=%~1"

if not exist "%target%\." (
  echo Directory not found: "%target%" 1>&2
  exit /b 1
)

takeown.exe /F "%target%" /A /R /D Y
if errorlevel 1 exit /b %errorlevel%

icacls.exe "%target%" /reset /T /Q /C
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<directory^> /force
echo This assigns ownership to Administrators and resets inherited ACLs.
exit /b 2
