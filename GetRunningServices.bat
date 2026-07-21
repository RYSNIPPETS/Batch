@echo off
setlocal EnableExtensions DisableDelayedExpansion

powershell.exe -NoLogo -NoProfile -Command ^
  "Get-CimInstance Win32_Service -Filter 'Started=True' |" ^
  "  Sort-Object Name |" ^
  "  Format-Table -AutoSize Name, StartName"
exit /b %errorlevel%
