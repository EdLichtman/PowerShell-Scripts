# PowerShell-Scripts
Scripts created to dabble in PowerShell

# "DevToProd_Deploy"
1. Declare the primary bin you're deploying from
2. Plop the file in the parent folder of the secondary bin you're deploying to
3. Run Powershell

What the script does is creates a "backups" folder, copies secondary bin and Web.Config to backups\bin_dateStamp and then copies the primary bin dlls into the secondary bin dlls.

# "Prod_Rollback"
1. Plop the file in the parent folder of the bin for the project you are rolling back
2. Run Powershell

What the script does is rolls back the dlls in the most recent \backups\bin_dateStamp\bin and the web.config in the most recent \backups\bin_dateStamp.
