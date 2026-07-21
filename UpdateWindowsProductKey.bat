@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~2"=="" goto :usage
set "edition=%~1"
set "product_key=%~2"

dism.exe /online /Set-Edition:%edition% /ProductKey:%product_key% /AcceptEula
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<edition-id^> ^<product-key^>
echo Run "dism.exe /online /Get-TargetEditions" to list valid edition IDs.
exit /b 2
