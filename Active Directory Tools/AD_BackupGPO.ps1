# Author: Maio Cáceres
# Date: 2024-02-24
# Version: 1.0
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to backup all Group Policy Objects (GPOs) and store them in a specified directory with the current date.

Import-Module GroupPolicy

# Get the current date in the specified format
$date = Get-Date -Format dd.MM.yyyy

# Define the path for storing the GPO backups with the current date appended
$path ="D:\Task\BackupGPO\GPOBackup$date"

# Create a new directory for storing the GPO backups
New-Item -Path $path -ItemType Directory

# Backup all Group Policy Objects and store them in the specified directory
Backup-Gpo -All -Path $path
