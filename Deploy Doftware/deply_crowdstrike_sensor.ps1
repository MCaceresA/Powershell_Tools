# Author: Maio Cáceres
# Date: 2024-02-12
# Version: 1.0
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to install Falcon Sensor Crowdstrike by powershell

# Define variables
$ServiceName = "CSFalconService"
$FilePath = "******************"
$CID = "*************************"

# The token is generated in the Falcon console
$Token = "***********"

# Check if the service is installed
$service = Get-Service -Name $ServiceName

if ($service -eq $null) {
       
    # launch install with parameters and add -wait to wait to finish install
    Start-Process -FilePath $FilePath -ArgumentList "/install", "/quiet", "/norestart", "CID=$CID", "ProvToken=$Token" -Wait
} else {
    exit
}