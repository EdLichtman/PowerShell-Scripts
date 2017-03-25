###### Go to Backups Repository ######
$backupsFolder = Get-ChildItem | Where-Object {$_.name -eq "backups"}
	If ($backupsFolder) {
		cd '.\backups'
		###### Find the Last Backup ######
		$lastBackup = Get-ChildItem | sort name -Descending | select -First 1
		###### Rollback the last Bin ######
		Remove-Item -path ..\bin\*
		Copy-Item .\$lastBackup\bin\* ..\bin

		###### Rollback the last web.config ######
		If ((Get-ChildItem | Where-Object {$_.name -eq "$lastBackup\Web.config"})){
			Remove-Item -path ..\Web.config
			Copy-Item .\$lastBackup\Web.config ..\}
		Write-Host "Rollback Successful"
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	} Else {
		Write-Host "No Backups Found"
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	}