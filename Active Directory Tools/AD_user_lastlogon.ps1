# Author: Maio Cáceres
# Date: 2024-02-24
# Version: 1.0
# Email: m.caceres.asensio@gmail.com
# Description: PowerShell script to find computers with no login in last 60 days 

# Email configuration variables
$smtpServer = "****************************"
$smtpUsername = "****************************"
$smtpPassword = "****************************"
$smtpPort = 587
$recipient = "****************************"
$recipientBcc = "**************************************"
$subject = "Computer Last logon search result"

# Active Directory configuration variables and days limit
$limitDays = 60
$limitDate = (Get-Date).AddDays(-$limitDays)

# Get Active Directory computers with LastLogonTimestamp
$computers = Get-ADComputer -Filter * -Properties LastLogonTimestamp

# Filter computers with lastLogonTimestamp before the limit date
$computersWithLastLogon = $computers | Where-Object { [DateTime]::FromFileTime($_.LastLogonTimestamp) -lt $limitDate }

# Display computers with last logon more than $limitDays days ago
foreach ($computer in $computersWithLastLogon) {
    $lastLogonDate = [DateTime]::FromFileTime($computer.LastLogonTimestamp)
    $lastLogonDay = $lastLogonDate.ToString("yyyy-MM-dd")
    Write-Host "$($computer.Name) - Last logon: $lastLogonDay"
}

# Create email body with the results
$emailBody = "These are the computers with last logon more than $limitDays days ago:`n`n"
foreach ($computer in $computersWithLastLogon) {
    $lastLogonDate = [DateTime]::FromFileTime($computer.LastLogonTimestamp)
    $lastLogonDay = $lastLogonDate.ToString("yyyy-MM-dd")
    $emailBody += "$($computer.Name) - Last logon: $lastLogonDay`n"
}

# Send email with recipient and Bcc
Send-MailMessage -SmtpServer $smtpServer -Port $smtpPort -UseSsl -From $smtpUsername -To $recipient -Bcc $recipientBcc -Subject $subject -Body $emailBody -Credential (New-Object System.Management.Automation.PSCredential($smtpUsername,(ConvertTo-SecureString $smtpPassword -AsPlainText -Force)))
