@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
set "redirect_root=%~1"
set "key=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
set "roaming=%redirect_root%\AppData\Roaming"

call :set_folder "AppData" "%roaming%" || exit /b 1
call :set_folder "Desktop" "%redirect_root%\Desktop" || exit /b 1
call :set_folder "Favorites" "%redirect_root%\Favorites" || exit /b 1
call :set_folder "My Pictures" "%redirect_root%\Pictures" || exit /b 1
call :set_folder "Personal" "%redirect_root%\Documents" || exit /b 1
call :set_folder "Administrative Tools" "%roaming%\Microsoft\Windows\Start Menu\Programs\Administrative Tools" || exit /b 1
call :set_folder "NetHood" "%roaming%\Microsoft\Windows\Network Shortcuts" || exit /b 1
call :set_folder "PrintHood" "%roaming%\Microsoft\Windows\Printer Shortcuts" || exit /b 1
call :set_folder "Programs" "%roaming%\Microsoft\Windows\Start Menu\Programs" || exit /b 1
call :set_folder "Recent" "%roaming%\Microsoft\Windows\Recent" || exit /b 1
call :set_folder "SendTo" "%roaming%\Microsoft\Windows\SendTo" || exit /b 1
call :set_folder "Start Menu" "%roaming%\Microsoft\Windows\Start Menu" || exit /b 1
call :set_folder "Startup" "%roaming%\Microsoft\Windows\Start Menu\Programs\Startup" || exit /b 1
call :set_folder "Templates" "%roaming%\Microsoft\Windows\Templates" || exit /b 1

echo Folder locations updated. Sign out and back in to apply them.
exit /b 0

:set_folder
reg.exe add "%key%" /v "%~1" /t REG_EXPAND_SZ /d "%~2" /f >nul
exit /b %errorlevel%

:usage
echo Usage: %~nx0 ^<redirect-root^>
echo Example: %~nx0 "\\fileserver\Users\username"
exit /b 2
