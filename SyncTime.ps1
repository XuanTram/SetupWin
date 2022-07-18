<#
Script: Install winlogbeat on server 
Author: DMH
Date: 18/07/2022
#>

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" `"$args`"" -Verb RunAs; exit } #mo powershell duoi quyen admin

#change target NTP Server
.\Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Parameters" -Name "NtpServer" -Value "10.60.10.79,0x8"

# restart Windows Time service
.\Restart-Service w32Time 

# re-sync manually
.\w32tm /resync 

# verify status
w32tm /query /status