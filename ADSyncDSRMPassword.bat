@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage

ntdsutil.exe "set dsrm password" "sync from domain account %~1" quit quit
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<domain-account^>
exit /b 2
