@echo off
cls

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo PowerShell is not installed. Please install PowerShell and run the script again!
    echo.
    pause
    exit
)

for /f "delims=" %%V in ('powershell -Command "$PSVersionTable.PSVersion.Major.ToString() + '.' + $PSVersionTable.PSVersion.Minor.ToString()"') do set "PSVersion=%%V"

>nul 2>&1 net session || (
    color 0C
    echo This script requires administrator privileges.
    echo Please run the script as an administrator!
    echo.
    echo PowerShell version: %PSVersion%
    echo.
    echo.
    pause
    exit
)

echo ---------------------------------------------------------------------
echo                               Cleany (0.1)
echo.
echo     Warning: The script is running with administrator privileges!
echo           Warning: This version may contain bugs or issues!
echo                    PowerShell Version: %PSVersion%
echo ---------------------------------------------------------------------
echo.
echo.

:displayMenu
echo Would you like to continue?
echo    [1] Yes
echo    [2] No
echo    [3] View potential risks
echo.
set /p "choice=Enter your choice (1-3): "

if "%choice%"=="1" (
	echo.
    echo Proceeding with the script...
	echo.
) else if "%choice%"=="2" (
	echo.
    echo Script aborted!
	echo Waiting for 5 seconds before closing the window...
    timeout /nobreak /t 5 > nul
    exit
) else if "%choice%"=="3" (
	echo.
	echo.
    echo ---------------------------------------------------------------------
    echo                          POTENTIAL RISKS
    echo ---------------------------------------------------------------------
    echo 1. Deleting system files may cause instability or loss of data.
    echo 2. Stopping essential services can affect system functionality.
    echo 3. Restarting Explorer may temporarily interrupt desktop experience.
    echo 4. Cleaning system logs may impact troubleshooting capabilities.
    echo 5. Deleting Windows Update files might affect future updates.
    echo ---------------------------------------------------------------------
	echo.
	echo.
	echo.
    goto :displayMenu
) else (
    echo You have chosen an invalid option! Please select a correct option...
	echo.
    goto :displayMenu
)

echo --- Restarting Explorer ---
taskkill /F /IM explorer.exe

timeout 2 /nobreak >nul

echo.

echo --- Deleting Temporary Files ---
DEL /F /S /Q /A %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db
DEL /F /S /Q %temp%\
DEL /F /S /Q %temp%\*.tmp
DEL /F /S /Q %temp%\*
DEL /F /S /Q %systemdrive%\*.tmp
DEL /F /S /Q %systemdrive%\*._mp
DEL /F /S /Q %systemdrive%\*.log
DEL /F /S /Q %systemdrive%\*.gid
DEL /F /S /Q %systemdrive%\*.chk
DEL /F /S /Q %systemdrive%\*.old
DEL /F /S /Q %systemdrive%\recycled\*.*
DEL /F /S /Q %systemdrive%\$Recycle.Bin\*.*
DEL /F /S /Q %windir%\*.bak
DEL /F /S /Q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
DEL /F /Q %userprofile%\cookies\*.*
DEL /F /Q %userprofile%\recent\*.*
DEL /F /S /Q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
DEL /F /S /Q "%userprofile%\Local Settings\Temp\*.*"
DEL /F /S /Q "%userprofile%\recent\*.*"

timeout 3 /nobreak >nul

echo.

echo --- Restarting Explorer ---
Invoke-Command COMPUTERNAME -command{Stop-Process -ProcessName Explorer}
Invoke-Command COMPUTERNAME -command{Start-Process -ProcessName Explorer}
powershell Start explorer.exe

echo.

echo --- Stopping Services ---
net stop UsoSvc
net stop bits
net stop dosvc

echo.

echo --- Deleting Windows Update Files ---
rd /s /q C:\Windows\SoftwareDistribution
md C:\Windows\SoftwareDistribution

echo.

echo --- Cleaning System Logs ---
cd /
del *.log /a /s /q /f

echo.

echo --- Running Windows Cleaner ---
start "" /wait "C:\Windows\System32\cleanmgr.exe" /sagerun:50 

echo.

:setNSR
set /p "skipNSR=Want to check out our other project? (Y/N): "
if /i "%skipNSR%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Network-Settings-Reset"
) else if /i "%skipNSR%"=="N" (
	echo Skiping this section...
	goto: setRestart
) else (
	echo You have chosen an invalid option! Please select a correct option...
	echo.
	goto :setNSR
)

echo.

:setRestart
set /p "skipRestartChoice=Do you want to restart the computer now? (Y/N): "
if /i "%skipRestartChoice%"=="Y" (
    echo Thank you for utilizing the script! Your computer will restart shortly...
    timeout /nobreak /t 4 > nul
    shutdown /r /t 5 /f
) else if /i "%skipRestartChoice%"=="N" (
    echo Thank you for utilizing the script! Please remember to restart your computer when convenient.
    echo Waiting for 5 seconds before closing the window...
    timeout /nobreak /t 4 > nul
    exit
) else (
    echo You have chosen an invalid option! Please select a correct option...
    echo.
    goto :setRestart
)

:eof
