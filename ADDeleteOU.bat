@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
if /I not "%~2"=="/force" goto :usage

echo Deleting "%~1" and its entire subtree.
dsrm.exe "%~1" -subtree -noprompt
exit /b %errorlevel%

:usage
echo Usage: %~nx0 "OU=Finance,DC=example,DC=com" /force
echo The /force argument is required because this operation is destructive.
exit /b 2
