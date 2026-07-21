@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~6"=="" goto :usage

set "BATCH_DOMAIN=%~1"
set "BATCH_SITE=%~2"
set "BATCH_IFM_PATH=%~3"
set "BATCH_DATABASE_PATH=%~4"
set "BATCH_LOG_PATH=%~5"
set "BATCH_SYSVOL_PATH=%~6"

powershell.exe -NoLogo -NoProfile -Command ^
  "$ErrorActionPreference = 'Stop';" ^
  "Install-WindowsFeature AD-Domain-Services -IncludeManagementTools | Out-Null;" ^
  "Import-Module ADDSDeployment;" ^
  "$credential = Get-Credential -Message ('Credentials for ' + $env:BATCH_DOMAIN);" ^
  "$dsrmPassword = Read-Host 'Directory Services Restore Mode password' -AsSecureString;" ^
  "$parameters = @{" ^
  "  DomainName = $env:BATCH_DOMAIN;" ^
  "  Credential = $credential;" ^
  "  SiteName = $env:BATCH_SITE;" ^
  "  InstallationMediaPath = $env:BATCH_IFM_PATH;" ^
  "  InstallDns = $true;" ^
  "  DatabasePath = $env:BATCH_DATABASE_PATH;" ^
  "  LogPath = $env:BATCH_LOG_PATH;" ^
  "  SysvolPath = $env:BATCH_SYSVOL_PATH;" ^
  "  SafeModeAdministratorPassword = $dsrmPassword" ^
  "};" ^
  "Install-ADDSDomainController @parameters"
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<domain^> ^<site^> ^<ifm-path^> ^<database-path^> ^<log-path^> ^<sysvol-path^>
echo Example: %~nx0 example.com Default-First-Site-Name C:\IFM E:\NTDS E:\Logs E:\SYSVOL
exit /b 2
