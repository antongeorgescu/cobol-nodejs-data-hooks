$WorkingDir=$args[0]
# $WorkingDir = "C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os"
$Executable = Join-Path $WorkingDir "\studentwrite.exe"

Set-Location $WorkingDir
& $Executable
