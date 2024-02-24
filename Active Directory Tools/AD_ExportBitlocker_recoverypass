# Author: Maio Cáceres
# Date: 2024-02-24
# Version: 1.0
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to export BitLocker recovery keys from Active Directory.

Import-Module ActiveDirectory

# Define the output file path
$outputFilePath = "D:\Task\ExportBitlockerKeys\ExportBitlockerKeys.txt"

# Get computer objects from Active Directory
$computers = Get-ADComputer -Filter * -Properties DistinguishedName

# Iterate over each computer object
$output = Foreach ($computer in $computers) {
    # Get BitLocker recovery information for the current computer
    $Bitlocker_Object = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $computer.DistinguishedName -Properties 'msFVE-RecoveryPassword'
    $Bitlocker_Object
}

# Export BitLocker recovery information to the specified file
$output | Out-File -FilePath $outputFilePath