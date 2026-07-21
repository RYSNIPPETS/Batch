@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage

ntdsutil.exe "activate instance ntds" ifm "create full %~1" quit quit
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<output-directory^>
exit /b 2
