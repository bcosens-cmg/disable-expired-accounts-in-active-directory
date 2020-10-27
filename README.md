Disable expired accounts in Active Directory.
=============================================

            

This script is a simple solution for disabling accounts that are expired in the Active Directory. The script was developed to block sign in for accounts synchonized to Azure Active Directory (Microsoft Office 365) that use Password Hash Synchronization.
 Microsoft currently allows expired accounts to sign into Microsoft Online Services even though the account has expired.


See this blog post for more information:


[https://blog.peterdahl.net/2017/09/18/office-365-azure-ad-block-sign-in-for-accounts-with-password-hash-sync/](https://blog.peterdahl.net/2017/09/18/office-365-azure-ad-block-sign-in-for-accounts-with-password-hash-sync/)


 


**Supported scenario from Microsoft:**


![Image](https://github.com/azureautomation/disable-expired-accounts-in-active-directory./raw/master/account-expiration.png)


Source: https://docs.microsoft.com/en-us/azure/active-directory/connect/active-directory-aadconnectsync-implement-password-synchronization


 


 

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
