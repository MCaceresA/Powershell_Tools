# Author: Maio Cáceres
# Date: 2024-02-24
# Version: 1.5
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to start a specified service on Windows and log the start events to a text file.

# Name of the service you want to start
$serviceName = "*******"

# Path to the log directory
$logDirectory = "*******"

# Get the current date for the log file
$logDate = Get-Date -Format "yyyy-MM-dd"

# Path to the log file with current date and service name
$logFile = Join-Path -Path $logDirectory -ChildPath "$serviceName-ServiceLog_$logDate.txt"

# Delete log files older than 7 days
$oldLogs = Get-ChildItem -Path $logDirectory -Filter "$serviceName-ServiceLog_*.txt" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }
$oldLogs | Remove-Item -Force

# Start the service
Start-Service -Name $serviceName

# Get the current timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Log the start event to the text file
Add-Content -Path $logFile -Value "$timestamp - Started service: $serviceName"
