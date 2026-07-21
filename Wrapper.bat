# 2>nul & @echo off & setlocal & set "BATCH_WRAPPER_PATH=%~f0" & powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create([IO.File]::ReadAllText($env:BATCH_WRAPPER_PATH)))" & exit /b

'Hello, World!' | Write-Output
