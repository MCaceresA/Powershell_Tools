# Author: Maio Cáceres
# Date: 2024-02-24
# Version: 1.1
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to backup Group Policy Objects (GPOs) and keep only the last 10 backups.

# Define the log directory path
$logDirectory = "C:\Task\BackupGPO\Logs"
if (-not (Test-Path $logDirectory)) {
    New-Item -Path $logDirectory -ItemType Directory | Out-Null
}

# Get the current date and time
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Define the current log file path
$logFile = Join-Path -Path $logDirectory -ChildPath "BackupLog_$timestamp.log"

# Function to write to the log file
function Write-Log {
    param (
        [string]$Message
    )
    $logMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    Add-Content -Path $logFile -Value $logMessage
}

# Import the Group Policy module
Import-Module GroupPolicy
Write-Log "Module 'GroupPolicy' imported successfully."

# Get the current date in the dd.MM.yyyy format
$date = Get-Date -Format "dd.MM.yyyy"
Write-Log "Current date is $date."

# Build the backup directory path using the current date
$path = "C:\Task\BackupGPO\GPOBackup$date"
Write-Log "Backup directory path: $path."

# Create a new directory at the specified path
New-Item -Path $path -ItemType Directory | Out-Null
Write-Log "Backup directory created successfully."

# Find and delete older backups if there are more than 10
$backups = Get-ChildItem "C:\Task\BackupGPO\" | Where-Object { $_.PSIsContainer -and $_.Name -match 'GPOBackup' } | Sort-Object CreationTime -Descending
if ($backups.Count -ge 10) {
    $backupsToDelete = $backups | Select-Object -Skip 10
    $backupsToDelete | Remove-Item -Recurse -Force
    Write-Log "Old backup directories cleaned up. Total backups: $($backups.Count)."
}

# Perform the backup of all Group Policy Objects (GPOs) to the created directory
Backup-Gpo -All -Path $path
Write-Log "GPOs backed up successfully."