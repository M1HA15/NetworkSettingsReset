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
    echo PowerShell version: %PSVersion%
    echo.
    pause
    exit
)

echo ---------------------------------------------------------------------
echo                             NSR(0.1) by Mihai       
echo.
echo     Warning: The script is running with administrator privileges.
echo                    PowerShell Version: %PSVersion%
echo ---------------------------------------------------------------------
echo.
echo.

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
echo.

echo [6] Set DNS provider:
echo     [1] Cloudflare (1.1.1.1)
echo     [2] Google (8.8.8.8)
echo     [3] OpenDNS (208.67.222.222)
echo     [4] Quad9 (9.9.9.9)
echo.

set /p "dnsChoice=Choose DNS provider (1-4, press Enter to skip): "
echo.
if not defined dnsChoice goto :skipDNS

if "%dnsChoice%"=="1" (
    set DNS_IP=1.1.1.1
    set DNS_Secondary_IP=1.0.0.1
    set DNS_IPv6=2606:4700:4700::1111
) else if "%dnsChoice%"=="2" (
    set DNS_IP=8.8.8.8
    set DNS_Secondary_IP=8.8.4.4
    set DNS_IPv6=2001:4860:4860::8888
) else if "%dnsChoice%"=="3" (
    set DNS_IP=208.67.222.222
    set DNS_Secondary_IP=208.67.220.220
    set DNS_IPv6=208.67.220.220
) else if "%dnsChoice%"=="4" (
    set DNS_IP=9.9.9.9
    set DNS_Secondary_IP=149.112.112.112
    set DNS_IPv6=2620:fe::fe
) else (
    echo Invalid choice. Press any key to close the window...
    pause > nul
    exit
)

if defined DNS_IP (
    powershell -Command "& { Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Up' } | ForEach-Object { Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses @('%DNS_IP%', '%DNS_Secondary_IP%') } }"
    echo DNS set to %DNS_IP% with secondary DNS %DNS_Secondary_IP%
)

if defined DNS_IPv6 (
    powershell -Command "& { Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Up' } | ForEach-Object { Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses @('%DNS_IPv6%') } }"
    echo IPv6 DNS set to %DNS_IPv6%
) else (
    echo DNS configuration skipped.
)

echo.

:skipDNS
set /p "skipGitHub=Do you want to open the GitHub page of this project? (Y/N): "
if /i "%skipGitHub%"=="Y" (
	echo Opening default web browser...
    start "" "https://github.com/M1HA15/Network-Settings-Reset"
)

echo.
set /p "skipRestartChoice=Do you want to restart the computer now? (Y/N): "
if /i "%skipRestartChoice%"=="Y" (
    echo Restarting the computer...
    shutdown /r /t 5 /f
) else if /i "%skipRestartChoice%"=="N" (
    exit
) else (
    echo Invalid choice. Press any key to close the window...
    pause > nul
)

:eof
