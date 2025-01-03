<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Dylan Leonard
    LinkedIn        : https://www.linkedin.com/in/dylan-leonard-b0962825b/
    GitHub          : https://github.com/dylanleonard-1
    Date Created    : 2025-01-03
    Last Modified   : 2025-01-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 2025-01-03
    Tested By       : Dylan Leonard
    Systems Tested  : Windows 10
    PowerShell Ver. : powershell ise

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE
# Define the registry path and key name
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$regName = "MaxSize"
$regValue = 0x00032768  # Hexadecimal value equivalent to dword:00032768

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating it now..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog" -Name "Application" -Force
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue

Write-Host "Registry key $regName set to $regValue at $regPath"
