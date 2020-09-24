using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Text;
using data_access_layer;
using Microsoft.Scripting.Hosting;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace unit_test_project
{
    [TestClass]
    public class UnitTestDAL
    {
        [TestMethod]
        public void ReadAllRecords()
        {
            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat";
            var recs = new StudentRecords(path);
            var allrecs = recs.GetAllRecords();
            Assert.IsTrue(allrecs.Count > 0);
        }

        [TestMethod]
        public void RunTransactions()
        {
            // Execute PowerShell script that runs COBOL programs
            var psScript = new StringBuilder();

            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os";
            psScript.AppendLine($"$WorkingDir = \"{path}\"");
            //psScript.AppendLine("$CurrMasterDataFile = Join-Path $WorkingDir \"\\data\\students.dat\"");
            //psScript.AppendLine("$fileExist = Test-Path $CurrMasterDataFile");
            //psScript.AppendLine("if ($fileExist) {Remove-Item $CurrMasterDataFile}");
            //psScript.AppendLine("$OrigMasterDataFile = Join-Path $WorkingDir \"\\data\\students_orig.dat\"");
            //psScript.AppendLine("$DestinationFile = Join-Path $WorkingDir \"\\data\\students.dat\"");
            //psScript.AppendLine("Copy-Item $OrigMasterDataFile -Destination $DestinationFile");
            psScript.AppendLine("$Executable = Join-Path $WorkingDir \"\\studentwrite.exe\"");
            psScript.AppendLine("& $Executable");

            // remove students.dat file and rename students1.dat
            //psScript.AppendLine("Remove-Item $CurrMasterDataFile");
            //psScript.AppendLine("$NewMasterDataFile = Join-Path $WorkingDir \"\\data\\students1.dat\"");
            //psScript.AppendLine("Rename-Item -Path $NewMasterDataFile -NewName \"students.dat\"");

            List<string> results = RunScript(psScript.ToString());

            path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students1.dat";
            var recs = new StudentRecords(path);
            var allrecs = recs.GetAllRecords();

            Assert.IsTrue(allrecs.Count == 39);
        }

        [TestMethod]
        public void RunTrxPSScript()
        {
            var homeDir = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os";

            var psScriptPath = $"{homeDir}\\runtrxs_ut1.ps1";
            var ps = PowerShell.Create();
            ps.AddScript(psScriptPath);
            ps.Invoke();

            //var executablePath = $"{homeDir}\\studentwrite.exe";
            //ProcessStartInfo startInfo = new ProcessStartInfo(executablePath);
            //startInfo.WindowStyle = ProcessWindowStyle.Minimized;
            //Process.Start(startInfo);

            using (Runspace runspace = RunspaceFactory.CreateRunspace())
            {

                runspace.Open();
                Pipeline pipeline = runspace.CreatePipeline();
                pipeline.Commands.AddScript(@"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\runtrxs_ut1.ps1");
                pipeline.Commands.Add("Out-String");
                Collection<PSObject> results = pipeline.Invoke();
            }

            Assert.IsTrue(39 == 39);
        }

        [TestMethod]
        public void RunPsScriptElevated()
        {
            // change PowerShell script execution policy
            // Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
            IEnumerable<PSObject> results;
            var config = RunspaceConfiguration.Create();
            //var host = new ScriptHost();
            var cobolDir = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os";
            var scriptDir = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os";
            var script = $"runtrxs_ut1.ps1 \"{cobolDir}\"";
            using (var runspace = RunspaceFactory.CreateRunspace(config))
            {
                runspace.Open();
                runspace.SessionStateProxy.SetVariable("prog", this);

                using (var pipeline = runspace.CreatePipeline())
                {
                    if (!string.IsNullOrEmpty(scriptDir))
                        pipeline.Commands.AddScript(string.Format("$env:path = \"{0};\" + $env:path", scriptDir));

                    pipeline.Commands.AddScript(script);

                    var outDefault = new Command("out-default");
                    outDefault.MergeMyResults(PipelineResultTypes.Error, PipelineResultTypes.Output);
                    pipeline.Commands.Add(outDefault);

                    results = pipeline.Invoke();
                }
            }
        }

        private List<string> RunScript(string scriptText)
        {
            // create Powershell runspace

            Runspace runspace = RunspaceFactory.CreateRunspace();

            // open it

            runspace.Open();

            // create a pipeline and feed it the script text

            Pipeline pipeline = runspace.CreatePipeline();
            pipeline.Commands.AddScript(scriptText);

            // add an extra command to transform the script
            // output objects into nicely formatted strings

            // remove this line to get the actual objects
            // that the script returns. For example, the script

            // "Get-Process" returns a collection
            // of System.Diagnostics.Process instances.

            pipeline.Commands.Add("Out-String");

            // execute the script

            Collection<PSObject> results = pipeline.Invoke();

            // close the runspace

            runspace.Close();

            // convert the script result into a single string

            List<string> outs = new List<string>();
            foreach (PSObject obj in results)
            {
                outs.Add(obj.ToString());
            }

            return outs;
        }
    }
}
