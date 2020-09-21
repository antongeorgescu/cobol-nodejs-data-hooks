
$CurrentDir = Get-Location

Write-Host "*** Reset Master Data file to its original content."
Write-Host "*** Press 'Y' to execute, any other key to exit...";

# $key = [System.Console]::ReadKey().Key.ToString();
# Write-Host ('User selected {0}' -f $key);
# Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());

$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').ToString().Split(",")[1].ToUpper();
if ($key -eq "Y")
{
    $CurrMasterDataFile = Join-Path $CurrentDir "\data\students.dat"
    $fileExist = Test-Path $CurrMasterDataFile
    if ($fileExist){
        Remove-Item $CurrMasterDataFile;
    }

    $OrigMasterDataFile = Join-Path $CurrentDir "\data\students_orig.dat"
    $DestinationFile = Join-Path $CurrentDir "\data\students.dat"
    Write-Host "Copying " $OrigMasterDataFile " to " $DestinationFile
    Copy-Item $OrigMasterDataFile -Destination $DestinationFile

    Write-Host "================================================================="
}
else {
    Write-Host "Program finishes at user request."
    return
} 

Write-Host "*** Run COBOL program that reads 'Students' sequential file."
Write-Host "*** Press 'Y' to continue, any other key to exit...";

# $key = [System.Console]::ReadKey().Key.ToString();
# Write-Host ('User selected {0}' -f $key);
# Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());

$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').ToString().Split(",")[1].ToUpper();
if ($key -eq "Y")
{
    Write-Host ""
    Write-Host "... Students Data (Master Data) ....................."
    Write-Host "-----------------------------------------------------"
    $StudentReadExe = "studentread.exe"
    $Executable = Join-Path $CurrentDir "\" $StudentReadExe
    & $Executable
    Write-Host "================================================================="
}
else {
    Write-Host "Program finishes at user request."
    return
} 

Write-Host "*** Run COBOL program that reads 'Transactions' file."
Write-Host "*** Press 'Y' to continue, any other key to exit...";

# $key = [System.Console]::ReadKey().Key.ToString();
# Write-Host ('User selected {0}' -f $key);
# Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());

$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').ToString().Split(",")[1].ToUpper();
if ($key -eq "Y")
{
    Write-Host ""
    Write-Host "... Transaction Entries ............................."
    Write-Host "-----------------------------------------------------"
    $TransactionReadExe = "transactionread.exe"
    $Executable = Join-Path $CurrentDir "\" $TransactionReadExe
    & $Executable
    Write-Host "================================================================="
}
else {
    Write-Host "Program finishes at user request."
    return
} 

Write-Host "*** Run COBOL program that apply the transactions on Master Data";
Write-Host "*** Press 'Y' to continue, any other key to exit...";

# $key = [System.Console]::ReadKey().Key.ToString();
# Write-Host ('User selected {0}' -f $key);
# Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());

$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').ToString().Split(",")[1].ToUpper();
if ($key -eq "Y")
{
    $StudentWriteExe = "studentwrite.exe"
    $Executable = Join-Path $CurrentDir "\" $StudentWriteExe
    & $Executable

    Write-Host "*** The transactions have been applied on Master Data";

    $CurrMasterDataFile = Join-Path $CurrentDir "\data\students.dat"
    Remove-Item $CurrMasterDataFile

    $NewMasterDataFile = Join-Path $CurrentDir "\data\students1.dat"
    Rename-Item -Path $NewMasterDataFile -NewName "students.dat"

    Write-Host "*** Display the updated Master Data";
    
    Write-Host ""
    Write-Host "... Students Data (Master Data) ....................."
    Write-Host "-----------------------------------------------------"
    $StudentReadExe = "studentread.exe"
    $Executable = Join-Path $CurrentDir "\" $StudentReadExe
    & $Executable
    Write-Host "================================================================="
}
else {
    Write-Host "Program finishes at user request."
    return
} 
