<# 
    .SYNOPSIS 
        This Azure Automation runbook disables expired accounts in Active Directory.  
 
    .DESCRIPTION 
        The runbook implements a simple solution for disabling accounts which are expired in the Active Directory.
        This script was developed to block sign in for accounts synchonized to Azure Active Directory (Microsoft Office 365)
        that use Password Hash Synchronization. Microsoft currently allows expired accounts to sign into Microsoft Online Services
        even though the account has expired.
        
        Script Version: 1.0
        Author: Peter Selch Dahl
        WWW: blog.peterdahl.net
        Last Updated: 9/18/2017
        The script is provided “AS IS” with no warranties or guarantees.

        Azure Feeback: Sync "Account Expired" UserAccountControl to Azure AD (AccountEnabled)
        https://feedback.azure.com/forums/169401-azure-active-directory/suggestions/31459621-sync-account-expired-useraccountcontrol-to-azure

        Use AAD Connect to disable accounts with expired on-premises passwords:
        https://blogs.technet.microsoft.com/undocumentedfeatures/2017/09/15/use-aad-connect-to-disable-accounts-with-expired-on-premises-passwords

        Supported scenario from Microsoft:
        "Account expiration
        If your organization uses the accountExpires attribute as part of user account management, 
        be aware that this attribute is not synchronized to Azure AD. As a result, an expired Active Directory 
        account in an environment configured for password synchronization will still be active in Azure AD. 
        We recommend that if the account is expired, a workflow action should trigger a PowerShell script that
        disables the user's Azure AD account. Conversely, when the account is turned on, the Azure AD instance 
        should be turned on."
        Source: https://docs.microsoft.com/en-us/azure/active-directory/connect/active-directory-aadconnectsync-implement-password-synchronization

    .PARAMETER ADSearchBase 
        Provide the Active Directory LDAP search base for finding the user objects. 

        Example 1: "CN=Users,DC=example,DC=com"
        Example 3: "DC=example,DC=com"
  
        For for details on LDAP Search:
        https://technet.microsoft.com/en-us/library/cc978021.aspx

    .EXAMPLE 
       See the documentation at: 
       
       http://blog.peterdahl.net/?p=60700&preview=true

    .OUTPUTS 
       Active Directory accounts that was disabled by the script.
#> 
 
param( 
    [parameter(Mandatory=$false)] 
    [String] $ADSearchBase = "CN=Users,DC=example,DC=com"
) 
 

Import-Module ActiveDirectory

$param=@{
UsersOnly = $True
AccountExpired = $True
SearchBase = $ADSearchBase 
}

Write-Output "Disabling the following accounts:"
$users = Search-ADAccount @param |
Get-ADuser -Properties Department,Title,AccountExpirationDate,SAMAccountName | where {$_.enabled -eq $true}

#$users | Select Name,Department,Title,DistinguishedName,AccountExpirationDate,SAMAccountName 
$i = 0
ForEach($user in $users)  
  {
   $date = Get-Date
   if($user.enabled -eq $true -and $user.AccountExpirationDate.ToString() -lt $date.ToString())  
    {  
      Write-Output "Disabling user: $($user.SAMAccountName)"
      Disable-ADAccount -Identity $user.SAMAccountName
      $i++  
    }  
 }  
 Write-Output " "
 Write-Output "Modified $i users"





