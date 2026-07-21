@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
if /I not "%~2"=="/force" goto :usage
set "share_root=%~1"

if not exist "%share_root%\." (
  echo Directory not found: "%share_root%" 1>&2
  exit /b 1
)

icacls.exe "%share_root%" /inheritance:r
if errorlevel 1 exit /b %errorlevel%

rem Remove built-in Users and Everyone grants, using SIDs for locale independence.
icacls.exe "%share_root%" /remove:g *S-1-5-32-545 *S-1-1-0
if errorlevel 1 exit /b %errorlevel%

icacls.exe "%share_root%" /grant:r ^
  "*S-1-5-18:(OI)(CI)(F)" ^
  "*S-1-5-32-544:(OI)(CI)(F)" ^
  "*S-1-3-0:(OI)(CI)(IO)(F)" ^
  "*S-1-5-11:(RX,AD)"
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<folder-redirection-root^> /force
echo This replaces inherited permissions on the specified root directory.
exit /b 2
