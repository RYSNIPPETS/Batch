@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Synchronize all partitions (/A) across sites (/e), push changes (/P),
rem and identify servers by distinguished name (/d).
if "%~1"=="" (
  repadmin.exe /syncall /A /P /e /d
) else (
  repadmin.exe /syncall "%~1" /A /P /e /d
)
exit /b %errorlevel%
