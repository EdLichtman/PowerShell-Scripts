###### Declare Bin to Copy from -- must be \bin ######
$binToDeploy = "~\bin(\Release)"
# Place this file in a folder with a bin file in it

###### Try to locate Bin
If (!(Get-ChildItem | Where-Object {$_.name -eq "bin"}))
{Write-Host "Could not find bin"

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
Else {
	###### Go to Backups Repository ######
	$backupsFolder = Get-ChildItem | Where-Object {$_.name -eq "backups"}
	If (!$backupsFolder) {
		New-Item -ItemType directory -Path ".\backups"
	}

	###### Create New Directory for backup ######
	$lastBackup = Get-ChildItem | Where-Object {$_.name -like "\backups\bin$(get-date -f yyyyMMdd)*"} | sort name -Descending | select -First 1

	If (!$lastBackup) {
		$newBackupName = ".backups\bin$(get-date -f yyyyMMdd)"
	} Else {
		$index = $lastBackup.Name.IndexOf("_")
		If ($index -eq -1) {
			$newBackupName = ".backups\bin$(get-date -f yyyyMMdd)_1"
		} Else {
			$lastBackupVersion = $lastBackup.Name[$index+1]
			$newBackupName = ".backups\bin$(get-date -f yyyyMMdd)_$($([convert]::ToInt32($lastBackupVersion, 10))+1)"
		}
	}
	New-Item -ItemType directory -Path $newBackupName\bin

	###### Copy the Bin and Web Config ######
	Copy-Item .\bin\* .backups\$newBackupName\bin

	If ((Get-ChildItem | Where-Object {$_.name -eq "Web.config"})){
	Copy-Item .\Web.config .backups\$newBackupName\}

	###### Delete the contents of the bin ######
	Remove-Item -path .\bin\* 

	###### Deploy the new bin ######
	Copy-Item $binToDeploy\* .\bin

	Write-Host "Finished Deploying"
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}