@echo off
title REPO Loader
color 0A

echo ========================================
echo            REPO Loader
echo ========================================
echo.

echo [1/5] Searching for REPO.exe...

for /f "tokens=2 delims=," %%a in ('wmic process where "name='REPO.exe'" get executablepath /format:csv ^| find ":"') do (
    set EXE=%%a
)

if not defined EXE (
    color 0C
    echo.
    echo [ERROR] REPO.exe not found
    pause
    exit
)

for %%F in ("%EXE%") do set DIR=%%~dpF

echo.
echo [2/5] Game path:
echo %DIR%

echo.
echo [3/5] Closing game...
taskkill /f /im REPO.exe >nul 2>&1

timeout /t 2 >nul

echo [OK] Closed

echo.
echo [4/5] Downloading version.dll...

powershell -Command ^
"Invoke-WebRequest 'https://raw.githubusercontent.com/ryt1235yt-pixel/chel/main/version.dll' -OutFile '%DIR%version.dll'"

if exist "%DIR%version.dll" (
    echo [OK] DLL installed
) else (
    color 0C
    echo [ERROR] DLL download failed
    pause
    exit
)

echo.
echo [5/5] Launching game...

start steam://rungameid/3241660

echo.
echo Done.
timeout /t 3 >nul
