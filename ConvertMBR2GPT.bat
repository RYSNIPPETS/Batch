@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
set "disk_number=%~1"
for /f "delims=0123456789" %%A in ("%disk_number%") do goto :usage

echo Validating disk %disk_number% for in-place MBR-to-GPT conversion...
mbr2gpt.exe /validate /disk:%disk_number% /allowFullOS
if errorlevel 1 exit /b %errorlevel%

if /I not "%~2"=="/convert" (
  echo Validation succeeded. Re-run with /convert to perform the conversion.
  exit /b 0
)

echo Converting disk %disk_number%. The firmware must use UEFI after conversion.
mbr2gpt.exe /convert /disk:%disk_number% /allowFullOS
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<disk-number^> [/convert]
echo Without /convert, the script only validates the disk.
exit /b 2
