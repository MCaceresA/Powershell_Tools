# Author: Maio Cáceres
# Date: 2024-02-24
# Version: 1.0
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to start the Zabbix Agent 2 service on Windows.

# Name of the service you want to start
$serviceName = "Zabbix Agent 2"

# Start the service
Start-Service -Name $serviceName
