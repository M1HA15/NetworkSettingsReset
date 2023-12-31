@echo off
cls

where powershell >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo PowerShell is not installed. Please install PowerShell and run the script again.
    echo.
    pause
    exit
)

for /f "delims=" %%V in ('powershell -Command "$PSVersionTable.PSVersion.Major.ToString() + '.' + $PSVersionTable.PSVersion.Minor.ToString()"') do set "PSVersion=%%V"

>nul 2>&1 net session || (
    color 0C
    echo This script requires administrator privileges.
    echo Please run the script as an administrator.
    echo.
    echo PowerShell version: %PSVersion%
    echo.
    echo.
    pause
    exit
)

echo ---------------------------------------------------------------------
echo                               NSR (0.4)
echo.
echo     Warning: The script is running with administrator privileges!
echo           Warning: This version may contain bugs or issues!
echo                    PowerShell Version: %PSVersion%
echo ---------------------------------------------------------------------
echo.
echo.
timeout /nobreak /t 2 > nul

echo [1] Flushing DNS...
ipconfig /flushdns
echo.

echo [2] Registering DNS...
ipconfig /registerdns
echo.

echo [3] Releasing IP...
ipconfig /release
echo.

echo [4] Renewing IP...
ipconfig /renew
echo.

echo [5] Resetting Winsock...
netsh winsock reset
echo.

timeout /nobreak /t 1 > nul

echo [6] Set DNS provider:
echo     [1] Recommended DNS Providers
echo     [2] Input your DNS Providers
echo     [3] Skip
echo.

set /p "dnsChoice=Choose DNS provider (1-3): "
echo.

if "%dnsChoice%"=="" goto :eof

if "%dnsChoice%"=="1" goto :recommendedDNS
if "%dnsChoice%"=="2" goto :customDNS
if "%dnsChoice%"=="3" goto :skipDNS

echo Invalid choice. Please select a valid option.
goto :eof

:recommendedDNS
echo Testing DNS providers to find the best one for you...
for %%i in (1.1.1.1 208.67.222.222 95.85.95.85 9.9.9.9 8.8.8.8) do (
    for /f "tokens=*" %%a in ('ping -n 4 -w 1000 %%i ^| find "Minimum"') do (
        echo %%i: %%a
    )
)
echo.
echo Testing complete! The DNS provider with the lowest ping times may be the best choice for you.
echo.
echo.
echo Choose a recommended DNS provider:
echo     [1] Cloudflare (1.1.1.1)
echo     [2] Cisco Umbrella (208.67.222.222)
echo     [3] GCore (95.85.95.85)
echo     [4] Quad9 (9.9.9.9)
echo     [5] Google (8.8.8.8)
echo.
set /p "recommendedDNSChoice=Enter your choice (1-5): "
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

:customDNS
set /p "visitDNSPerf=Do you want to visit DNSPerf to choose a DNS provider? (Y/N): "
if /i "%visitDNSPerf%"=="Y" (
    start "" "https://www.dnsperf.com/"
)
echo.
echo Please input the IPv4 and IPv6 addresses of the selected DNS provider!
set /p "DNS_IP=Enter your primary IPv4 DNS address: "
set /p "DNS_Secondary_IP=Enter your secondary IPv4 DNS address: "
set /p "DNS_IPv6=Enter your primary IPv6 DNS address: "
set /p "DNS_Secondary_IPv6=Enter your secondary IPv6 DNS address: "
echo Please wait a moment while we configure the desired addresses for the selected DNS provider.
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

:setGitHub
set /p "skipGitHub=Do you want to open the GitHub page of this project? (Y/N): "
if /i "%skipGitHub%"=="Y" (
    echo Opening default web browser...
    start "" "https://github.com/M1HA15/Network-Settings-Reset"
)
echo.

:setRestart
set /p "skipRestartChoice=Do you want to restart the computer now? (Y/N): "
if /i "%skipRestartChoice%"=="Y" (
    echo We appreciate you using the script. Your computer will restart shortly!
    shutdown /r /t 5 /f
) else if /i "%skipRestartChoice%"=="N" (
    echo We appreciate you using the script. Don't forget to restart your computer later!
    echo Waiting for 5 seconds before closing the window...
    timeout /nobreak /t 4 > nul
    exit
) else (
	echo You have chosen an invalid option! Please select a correct option...
	echo.
	goto :setRestart
)

:eof
