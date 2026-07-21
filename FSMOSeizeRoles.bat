@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
if /I not "%~2"=="/force" goto :usage
set "BATCH_TARGET_DC=%~1"

echo Seizing all FSMO roles onto %BATCH_TARGET_DC%.
echo Do not reconnect a previous role holder until it has been rebuilt.
powershell.exe -NoLogo -NoProfile -Command ^
  "$ErrorActionPreference = 'Stop';" ^
  "Import-Module ActiveDirectory;" ^
  "$roles = 'SchemaMaster', 'DomainNamingMaster', 'PDCEmulator', 'RIDMaster', 'InfrastructureMaster';" ^
  "Move-ADDirectoryServerOperationMasterRole -Identity $env:BATCH_TARGET_DC -OperationMasterRole $roles -Force -Confirm:$false"
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<target-domain-controller^> /force
echo Use role seizure only when the existing role holder will not return.
exit /b 2
