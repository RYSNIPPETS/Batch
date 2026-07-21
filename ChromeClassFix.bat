@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Remove stale DelegateExecute values from loaded user registry hives.
powershell.exe -NoLogo -NoProfile -Command ^
  "$ErrorActionPreference = 'Stop';" ^
  "$relativeKeys = @(" ^
  "  'Software\Classes\Chrome\.exe\shell\open\command'," ^
  "  'Software\Classes\Chrome\.exe\shell\opennewwindow\command'," ^
  "  'Software\Classes\ChromeHTML\shell\open\command'" ^
  ");" ^
  "$profiles = Get-CimInstance Win32_UserProfile | Where-Object { $_.Loaded -and $_.SID -like 'S-1-5-21-*' };" ^
  "foreach ($profile in $profiles) {" ^
  "  foreach ($relativeKey in $relativeKeys) {" ^
  "    $path = 'Registry::HKEY_USERS\' + $profile.SID + '\' + $relativeKey;" ^
  "    if (Get-ItemProperty -LiteralPath $path -Name DelegateExecute -ErrorAction SilentlyContinue) {" ^
  "      Remove-ItemProperty -LiteralPath $path -Name DelegateExecute;" ^
  "      Write-Host ('Removed DelegateExecute from ' + $path);" ^
  "    }" ^
  "  }" ^
  "}"
exit /b %errorlevel%
