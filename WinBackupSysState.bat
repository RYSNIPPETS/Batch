@echo off
setlocal EnableExtensions DisableDelayedExpansion

if /I "%~1"=="backup" goto :backup
if /I "%~1"=="list" goto :list
if /I "%~1"=="restore" goto :restore
goto :usage

:backup
if "%~2"=="" goto :usage
wbadmin.exe start systemstatebackup -backupTarget:"%~2"
exit /b %errorlevel%

:list
if "%~2"=="" (
  wbadmin.exe get versions
) else (
  wbadmin.exe get versions -backupTarget:"%~2"
)
exit /b %errorlevel%

:restore
if "%~3"=="" goto :usage
if /I not "%~4"=="/force" goto :usage
wbadmin.exe start systemstaterecovery -version:%~2 -backupTarget:"%~3" -authsysvol
exit /b %errorlevel%

:usage
echo Usage:
echo   %~nx0 backup ^<backup-target^>
echo   %~nx0 list [backup-target]
echo   %~nx0 restore ^<MM/DD/YYYY-HH:MM^> ^<backup-target^> /force
echo The restore command performs an authoritative SYSVOL recovery.
exit /b 2
