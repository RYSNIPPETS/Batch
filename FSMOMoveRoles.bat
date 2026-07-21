@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
set "BATCH_TARGET_DC=%~1"

powershell.exe -NoLogo -NoProfile -Command ^
  "$ErrorActionPreference = 'Stop';" ^
  "Import-Module ActiveDirectory;" ^
  "$roles = 'SchemaMaster', 'DomainNamingMaster', 'PDCEmulator', 'RIDMaster', 'InfrastructureMaster';" ^
  "Move-ADDirectoryServerOperationMasterRole -Identity $env:BATCH_TARGET_DC -OperationMasterRole $roles"
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<target-domain-controller^>
exit /b 2
