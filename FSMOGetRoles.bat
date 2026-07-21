@echo off
setlocal EnableExtensions DisableDelayedExpansion

netdom.exe query FSMO
exit /b %errorlevel%
