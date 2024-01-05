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
echo                               NSR (0.6)
echo.
echo     Warning: The script is running with administrator privileges!
echo           Warning: This version may contain bugs or issues!
echo                    PowerShell Version: %PSVersion%
echo ---------------------------------------------------------------------
echo.
echo.
timeout /nobreak /t 3 > nul

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

timeout /nobreak /t 2 > nul


:menuDNS
echo [6] DNS Provider:
echo     [1] Recommended DNS Providers
echo     [2] Test Recommended DNS Providers
echo     [3] Input your DNS Provider
echo     [4] Test your DNS Provider
echo     [5] Skip
echo.

set /p "dnsChoice=Enter your choice (1-4): "
echo.

if "%dnsChoice%"=="" goto :menuDNS

if "%dnsChoice%"=="1" goto :recommendedDNS
if "%dnsChoice%"=="2" goto :pingDNS
if "%dnsChoice%"=="3" goto :customDNS
if "%dnsChoice%"=="4" goto :pingDNS2
if "%dnsChoice%"=="5" goto :skipDNS

echo Invalid choice! Returning to the DNS menu...
echo.
goto :menuDNS

:recommendedDNS
echo Choose a Recommended DNS Provider:
echo     [1] Cloudflare (1.1.1.1)
echo     [2] Cisco Umbrella (208.67.222.222)
echo     [3] GCore (95.85.95.85)
echo     [4] Quad9 (9.9.9.9)
echo     [5] Google (8.8.8.8)
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
    goto :recommendedDNS
	echo.
)
goto :setDNS

:pingDNS
echo Commencing Recommended DNS Providers Evaluation...
echo Please be aware that this analysis may require some time to complete.
echo.
echo Warning: This thorough evaluation includes the transmission of 20 packets, with each packet carrying 32 bytes of data, to every DNS Providers!
echo.
echo.
for %%i in (1.1.1.1 208.67.222.222 95.85.95.85 9.9.9.9 8.8.8.8) do (
    for /f "tokens=*" %%a in ('ping -n 20 -w 1000 %%i ^| find "Minimum"') do (
		echo Results for %%i:
        echo %%a
		echo.
    )
)
echo Testing complete! The DNS Provider with the lowest ping times may be the optimal choice for your network.
echo.
goto :menuDNS

:pingDNS2
echo Commencing DNS Provider Evaluation...
echo Please be aware that this analysis may require some time to complete.
echo.
echo Warning: This thorough evaluation includes the transmission of 20 packets, with each packet carrying 32 bytes of data, to the specified DNS Provider!
echo.
echo.

set /p "customDNS=Enter your DNS Provider: "

for /f "tokens=*" %%a in ('ping -n 20 -w 1000 %customDNS% ^| find "Minimum"') do (
    echo Results for %customDNS%:
    echo %%a
    echo.
)

echo Testing complete! The DNS Provider with the lowest ping times may be the optimal choice for your network.
echo.
goto :menuDNS

:customDNS
set /p "visitDNSPerf=Do you want to visit DNSPerf to choose a DNS Provider? (Y/N): "
if /i "%visitDNSPerf%"=="Y" (
    start "" "https://www.dnsperf.com/"
)
echo.
echo Please input the IPv4 and IPv6 addresses of the selected DNS Provider!
set /p "DNS_IP=Enter your Primary IPv4 DNS address: "
set /p "DNS_Secondary_IP=Enter your Secondary IPv4 DNS address: "
set /p "DNS_IPv6=Enter your Primary IPv6 DNS address: "
set /p "DNS_Secondary_IPv6=Enter your Secondary IPv6 DNS address: "
echo.
echo Please wait a moment while we configure the desired addresses for the selected DNS Provider...
echo.
goto :setDNS

:skipDNS
echo Skipping DNS provider selection...
echo.
goto :setGitHub

:setDNS
if not "%DNS_IP%"=="" (
    powershell -Command "& { Get-NetAdapter | ForEach-Object { try { Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses @('%DNS_IP%', '%DNS_Secondary_IP%') -ErrorAction Stop } catch { Write-Error $_ } } }"
    echo Primary IPv4 DNS set to %DNS_IP%
    echo Secondary IPv4 DNS set to %DNS_Secondary_IP%
)
if not "%DNS_IPv6%"=="" (
    powershell -Command "& { Get-NetAdapter | ForEach-Object { try { Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses @('%DNS_IPv6%', '%DNS_Secondary_IPv6%') -ErrorAction Stop } catch { Write-Error $_ } } }"
    echo Primary IPv6 DNS set to %DNS_IPv6%
    echo Secondary IPv6 DNS set to %DNS_Secondary_IPv6%
)
echo.
echo Successfully activated the selected DNS Provider!
echo.
echo.

:setGitHub
set /p "skipCleany=Want to check out our other project? (Y/N): "
if /i "%skipCleany%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Cleany"
) else if /i "%skipCleany%"=="N" (
	echo Skiping this section...
	goto :setRestart
) else (
	echo You have chosen an invalid option! Please select a correct option...
	echo.
	goto :setGitHub
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
