$WorkingDir=$args[0]
Set-Location $WorkingDir

$CurrMasterDataFile = Join-Path $WorkingDir "\data\students.dat"
$fileExist = Test-Path $CurrMasterDataFile
if ($fileExist) {Remove-Item $CurrMasterDataFile}
$OrigMasterDataFile = Join-Path $WorkingDir "\data\students_orig.dat"
$DestinationFile = Join-Path $WorkingDir "\data\students.dat"
Copy-Item $OrigMasterDataFile -Destination $DestinationFile

$Executable = Join-Path $WorkingDir "\studentwrite.exe"
& $Executable

# remove students.dat file and rename students1.dat
Remove-Item $CurrMasterDataFile
$NewMasterDataFile = Join-Path $WorkingDir "\data\students1.dat"
Rename-Item -Path $NewMasterDataFile -NewName "students.dat"