#line 1 "c:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\.vscode\launch.json"
{
 // Use IntelliSense to learn about possible attributes.
 // Hover to view descriptions of existing attributes.
 // For more information visit: https://go.microsoft.com/fwlink/?linkid=830387
 "version": "0.2.0"
 "configurations": [
 {
 "name": "COBOL debugger"
 "program": "${workspaceFolder}/${command:AskForProgramName}"
 "type": "gdb"
 "request": "launch"
 "cobcargs": ["-free" "-x"]
 "verbose": true
 }
 ]
}
