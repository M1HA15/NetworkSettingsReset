@echo off
cls
title NSR (0.7)

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo PowerShell is Not Installed. Please Install PowerShell and Run the Script Again!
    echo.
    pause
    exit
)

for /f "delims=" %%V in ('powershell -Command "$PSVersionTable.PSVersion.Major.ToString() + '.' + $PSVersionTable.PSVersion.Minor.ToString()"') do set "PSVersion=%%V"

>nul 2>&1 net session || (
    color 0C
    echo This Script equires Administrator Privileges.
    echo Please Run the Script as an Administrator!
    echo.
    echo PowerShell Version: %PSVersion%
    echo.
    pause
    exit
)


:mainMenu
cls
echo ===============================================================================
echo                                NSR (0.7)
echo                         PowerShell Version: %PSVersion%
echo                  Running with Administrator Privileges
echo ===============================================================================
echo.
echo.
echo.
echo [1] Network Maintenance (Recommended)
echo [2] Change DNS Provider
echo [3] Ping DNS Provider
echo [4] Info About Your PC
echo [5] Info About Script
echo [6] Exit
echo.
set /p "choice=Enter your choice (1-6): "
if "%choice%"=="1" goto :networkMaintenance
if "%choice%"=="2" goto :changeDNS
if "%choice%"=="3" goto :pingDNSMenu
if "%choice%"=="4" goto :infoPC
if "%choice%"=="5" goto :infoScript
if "%choice%"=="6" goto :exitMenu
goto :mainMenu

:networkMaintenance
cls
echo ---------------------------------------------------------------------
echo                      Network Maintenance
echo ---------------------------------------------------------------------
echo.
echo [1] Flushing DNS Cache...
ipconfig /flushdns
echo.

echo [2] Registering DNS...
ipconfig /registerdns
echo.

echo [3] Releasing IP Address...
ipconfig /release
echo.

echo [4] Renewing IP Address...
ipconfig /renew
echo.

echo [5] Resetting Winsock...
netsh winsock reset
echo.
echo.
echo.

echo Maintenance Completed Successfully!
echo.
pause
goto :mainMenu

:changeDNS
cls
echo ---------------------------------------------------------------------
echo                      Change DNS Provider
echo ---------------------------------------------------------------------
echo.
echo [1] Recommended DNS Providers
echo [2] Enter Your Provider
echo [3] Exit
echo.
set /p "dnsChoice=Enter your choice (1-3): "
if "%dnsChoice%"=="1" goto :recommendedDNS
if "%dnsChoice%"=="2" goto :customDNS
if "%dnsChoice%"=="3" goto :mainMenu
goto :changeDNS

:recommendedDNS
cls
echo ---------------------------------------------------------------------
echo                      Recommended DNS Providers
echo ---------------------------------------------------------------------
echo Choose a Recommended DNS Provider:
echo     [1] Cloudflare (1.1.1.1)
echo     [2] Cisco Umbrella (208.67.222.222)
echo     [3] GCore (95.85.95.85)
echo     [4] Quad9 (9.9.9.9)
echo     [5] Google (8.8.8.8)
echo.
echo Note: DNS Providers are listed based on performance data obtained from DNSPerf. Please be aware that actual performance may vary depending on your location and network conditions.
echo.
set /p "recommendedDNSChoice=Enter your choice (1-5): "
echo.
if "%recommendedDNSChoice%"=="1" (
    set DNS_IP=1.1.1.1
    set DNS_Secondary_IP=1.0.0.1
    set DNS_IPv6=2606:4700:4700::1111
    set DNS_Secondary_IPv6=2606:4700:4700::1001
) else if "%recommendedDNSChoice%"=="2" (
    set DNS_IP=208.67.222.222
    set DNS_Secondary_IP=208.67.220.220
    set DNS_IPv6=2620:119:35::35
    set DNS_Secondary_IPv6=2620:119:53::53
) else if "%recommendedDNSChoice%"=="3" (
    set DNS_IP=95.85.95.85
    set DNS_Secondary_IP=2.56.220.2
    set DNS_IPv6=2a03:90c0:999d::1
    set DNS_Secondary_IPv6=2a03:90c0:9992::1
) else if "%recommendedDNSChoice%"=="4" (
    set DNS_IP=9.9.9.9
    set DNS_Secondary_IP=149.112.112.112
    set DNS_IPv6=2620:fe::fe
    set DNS_Secondary_IPv6=2620:fe::9
) else if "%recommendedDNSChoice%"=="5" (
    set DNS_IP=8.8.8.8
    set DNS_Secondary_IP=8.8.4.4
    set DNS_IPv6=2001:4860:4860::8888
    set DNS_Secondary_IPv6=2001:4860:4860::8844
) else (
    echo.
    echo You have chosen an invalid option! Please select a correct option...
    pause
    goto :recommendedDNS
)
goto :setDNS

:customDNS
cls
echo ---------------------------------------------------------------------
echo                      Enter Your DNS Provider
echo ---------------------------------------------------------------------
echo.
set /p "DNS_IP=Enter your Primary IPv4 DNS address: "
set /p "DNS_Secondary_IP=Enter your Secondary IPv4 DNS address: "
set /p "DNS_IPv6=Enter your Primary IPv6 DNS address: "
set /p "DNS_Secondary_IPv6=Enter your Secondary IPv6 DNS address: "
echo.
goto :setDNS

:setDNS
cls
echo ---------------------------------------------------------------------
echo                      Setting DNS Provider
echo ---------------------------------------------------------------------
echo.
echo Setting IPv4 DNS...
timeout /nobreak /t 1 > nul
if not "%DNS_IP%"=="" (
    powershell -Command "& { Get-NetAdapter | ForEach-Object { try { Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses @('%DNS_IP%', '%DNS_Secondary_IP%') -ErrorAction Stop } catch { Write-Error $_ } } }"
    echo Primary IPv4 DNS set to %DNS_IP%
    echo Secondary IPv4 DNS set to %DNS_Secondary_IP%
)

echo.

echo Setting IPv6 DNS...
timeout /nobreak /t 1 > nul
if not "%DNS_IPv6%"=="" (
    powershell -Command "& { Get-NetAdapter | ForEach-Object { try { Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses @('%DNS_IPv6%', '%DNS_Secondary_IPv6%') -ErrorAction Stop } catch { Write-Error $_ } } }"
    echo Primary IPv6 DNS set to %DNS_IPv6%
    echo Secondary IPv6 DNS set to %DNS_Secondary_IPv6%
)
echo.
echo Successfully activated the selected DNS Provider!
echo.
pause
goto :mainMenu

:pingDNSMenu
cls
echo ---------------------------------------------------------------------
echo                      Ping DNS Provider
echo ---------------------------------------------------------------------
echo.
echo [1] Ping Recommended DNS Providers
echo [2] Ping Your DNS Provider
echo [3] Exit
echo.
set /p "pingChoice=Enter your choice (1-3): "
if "%pingChoice%"=="1" goto :pingRecommendedDNS
if "%pingChoice%"=="2" goto :pingCustomDNS
if "%pingChoice%"=="3" goto :mainMenu
goto :pingDNSMenu

:pingRecommendedDNS
cls
echo ---------------------------------------------------------------------
echo                      Ping Recommended DNS Providers
echo ---------------------------------------------------------------------
echo.
echo Note: This sequence will take some time to complete as it performs Ping Tests on Recommended DNS Providers. Please be patient while the script is running...
echo.
echo.

for %%i in (1.1.1.1 208.67.222.222 95.85.95.85 9.9.9.9 8.8.8.8) do (
    for /f "tokens=*" %%a in ('ping -n 30 -w 1000 %%i ^| find "Minimum"') do (
        echo Results for %%i:
        echo %%a
        echo.
    )
)
pause
goto :mainMenu

:pingCustomDNS
cls
set /p "customDNS=Enter your DNS Provider: "
echo.
echo Note: This sequence will take some time to complete as it performs Ping Tests on your Custom DNS Provider. Please be patient while the script is running...
echo.
echo.

for /f "tokens=*" %%a in ('ping -n 30 -w 1000 %customDNS% ^| find "Minimum"') do (
    echo Results for %customDNS%:
    echo %%a
    echo.
)
echo.
pause
goto :mainMenu

:infoPC
cls
echo ---------------------------------------------------------------------
echo                      Info About Your PC
echo ---------------------------------------------------------------------
echo.
systeminfo | more
pause
goto :mainMenu

:infoScript
cls
set "betaVersion=Y(0.3)"
echo ---------------------------------------------------------------------
echo                      Info About Script
echo ---------------------------------------------------------------------
echo.
echo Script Name: NSR
echo Version: 0.7
echo Author: M1HA15
echo Beta Version: %betaVersion%
echo.
set /p "openGitHub=Do you want to open NSR GitHub Page? (Y/N): "
if /i "%openGitHub%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Network-Settings-Reset"
)
echo.
echo.
set /p "openCleany=Do you want to check Cleany? (Y/N): "
if /i "%openCleany%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Cleany"
)
echo.
echo.
pause
goto :mainMenu

:exitMenu
echo.
set /p "skipRestartChoice=Do you want to restart the computer now? (Y/N): "
if /i "%skipRestartChoice%"=="Y" (
	echo.
    echo Thank you for utilizing the script! Your computer will restart shortly...
	timeout /nobreak /t 3 > nul
    shutdown /r /t 5 /f
	echo.
) else if /i "%skipRestartChoice%"=="N" (
	echo.
    echo Thank you for utilizing the script! Please remember to restart your computer when convenient.
    echo Waiting for 5 seconds before closing the window...
    timeout /nobreak /t 5 > nul
    exit
) else (
	echo You have chosen an invalid option! Please select a correct option...
	echo.
	goto :mainMenu
)

:eof
