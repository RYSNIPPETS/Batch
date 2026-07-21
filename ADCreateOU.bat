@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage

set "ou_dn=%~1"
set "description=%~2"
if not defined description set "description=Organizational unit"

dsadd.exe ou "%ou_dn%" -desc "%description%"
exit /b %errorlevel%

:usage
echo Usage: %~nx0 "OU=Finance,DC=example,DC=com" [description]
exit /b 2
