@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage

rem Pass a complete repadmin command line through to repadmin.exe.
repadmin.exe %*
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<repadmin arguments^>
echo.
echo Common commands:
echo   %~nx0 /kcc ^<domain-controller^>
echo   %~nx0 /queue ^<domain-controller^>
echo   %~nx0 /replsummary
echo   %~nx0 /showrepl ^<domain-controller^>
echo   %~nx0 /showobjmeta ^<domain-controller^> ^<object-DN^>
echo   %~nx0 /showutdvec ^<domain-controller^> ^<naming-context^>
echo   %~nx0 /syncall ^<domain-controller^> /A /e /d
echo.
echo Run repadmin.exe /? or repadmin.exe /help:command for complete syntax.
exit /b 2
