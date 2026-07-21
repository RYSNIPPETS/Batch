@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
set "BATCH_SERVICE_NAME=%~1"
set "BATCH_SERVICE_ACCOUNT=%~2"

powershell.exe -NoLogo -NoProfile -Command ^
  "$ErrorActionPreference = 'Stop';" ^
  "$credentialArgs = @{ Message = 'Enter the service account credentials' };" ^
  "if ($env:BATCH_SERVICE_ACCOUNT) { $credentialArgs.UserName = $env:BATCH_SERVICE_ACCOUNT };" ^
  "$credential = Get-Credential @credentialArgs;" ^
  "$password = $credential.GetNetworkCredential().Password;" ^
  "$service = Get-CimInstance Win32_Service | Where-Object Name -EQ $env:BATCH_SERVICE_NAME;" ^
  "if (-not $service) { throw ('Service not found: ' + $env:BATCH_SERVICE_NAME) };" ^
  "$changeArguments = @{ StartName = $credential.UserName; StartPassword = $password };" ^
  "$change = Invoke-CimMethod -InputObject $service -MethodName Change -Arguments $changeArguments;" ^
  "if ($change.ReturnValue -ne 0) { throw ('Service configuration failed with code ' + $change.ReturnValue) };" ^
  "Restart-Service -Name $env:BATCH_SERVICE_NAME -Force"
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<service-name^> [domain\account]
echo The password is requested securely and is not stored in this file.
exit /b 2
