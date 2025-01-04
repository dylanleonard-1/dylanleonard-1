<#
.SYNOPSIS
This PowerShell script configures the "Interactive logon: Message title for users attempting to log on" and "Interactive logon: Message text for users attempting to log on" policies.

.DESCRIPTION
The script sets a title and text for the logon banner by updating the appropriate registry keys. It complies with the security policy requirements outlined in WN10-SO-000075.

.PARAMETERS
None.

.NOTES
Author: [Your Name]
GitHub: [Your GitHub Profile Link]
Date: [Insert Date]
License: MIT
#>

# Define the title and message text
$title = "DoD Notice and Consent Banner"
$text = @"
You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.
By using this IS (which includes any device attached to this IS), you consent to the following conditions:
- The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.
- At any time, the USG may inspect and seize data stored on this IS.
- Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.
- This IS includes security measures (e.g., authentication and access controls) to protect USG interests -- not for your personal benefit or privacy.
- Notwithstanding the above, using this IS does not constitute consent to PM, LE, or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.
"@

# Registry keys for the policies
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$titleKey = "LegalNoticeCaption"
$textKey = "LegalNoticeText"

Write-Output "Starting configuration of logon policies..."

# Set the title
try {
    Set-ItemProperty -Path $regPath -Name $titleKey -Value $title
    Write-Output "Title successfully configured: $title"
} catch {
    Write-Error "Failed to set the title. Error: $_"
}

# Set the message text
try {
    Set-ItemProperty -Path $regPath -Name $textKey -Value $text
    Write-Output "Text successfully configured."
} catch {
    Write-Error "Failed to set the text. Error: $_"
}

# Force policy update
try {
    gpupdate /force
    Write-Output "Policy updated successfully."
} catch {
    Write-Error "Failed to update the policy. Error: $_"
}

Write-Output "Configuration complete. Please log off or lock your computer to verify the changes."
