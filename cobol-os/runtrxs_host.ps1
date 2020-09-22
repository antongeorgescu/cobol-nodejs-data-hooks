
$WorkingDir = "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os"

$CurrMasterDataFile = Join-Path $WorkingDir "\data\students.dat"
$fileExist = Test-Path $CurrMasterDataFile
if ($fileExist){
    Remove-Item $CurrMasterDataFile;
}

$OrigMasterDataFile = Join-Path $WorkingDir "\data\students_orig.dat"
$DestinationFile = Join-Path $WorkingDir "\data\students.dat"
    
Copy-Item $OrigMasterDataFile -Destination $DestinationFile

$Executable = Join-Path $WorkingDir "\studentwrite.exe"
& $Executable

    
