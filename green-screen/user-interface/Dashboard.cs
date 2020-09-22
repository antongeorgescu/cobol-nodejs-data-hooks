using data_access_layer;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace user_interface
{
    public partial class Dashboard : Form
    {
        public Dashboard()
        {
            InitializeComponent();
        }

        DataSet ds = null;

        private void Dashboard_Load(object sender, EventArgs e)
        {
            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat";
            var recs = new StudentRecords(path);
            var allrecs = recs.GetAllRecords();

            dgvStudentRecords.DataSource = null;
            //ds.Dispose();
            ds = new DataSet();
            ds.Tables.Add();
            ds.Tables[0].Columns.Add("StudentId");
            ds.Tables[0].Columns.Add("LastName");
            ds.Tables[0].Columns.Add("Initials");
            ds.Tables[0].Columns.Add("DOB");
            ds.Tables[0].Columns.Add("PhoneNo");
            ds.Tables[0].Columns.Add("ProgramCode");
            ds.Tables[0].Columns.Add("Gender");
            ds.Tables[0].Columns.Add("LoanAmount");
            foreach (var rec in allrecs)
                ds.Tables[0].Rows.Add(rec.StudentId,
                                        rec.LastName,
                                        rec.Initials,
                                        rec.DOB,
                                        rec.PhoneNo,
                                        rec.ProgramCode,
                                        rec.Gender,
                                        rec.LoanAmount);
            ds.Tables[0].AcceptChanges();
            dgvStudentRecords.DataSource = ds.Tables[0];
        }

        private void bnRunTransactions_Click(object sender, EventArgs e)
        {
            var changeTable = ds.Tables[0].GetChanges();

            // Update transins.dat table
            var rows = changeTable.Rows;
            var lines = new List<string>();
            
            foreach (DataRow row in rows)
            {
                var formattedLine = new StringBuilder();
                
                formattedLine.Append($"{row.ItemArray[0],-7}");
                formattedLine.Append($"{row.ItemArray[1].ToString().Substring(0,8),-8}");
                formattedLine.Append($"{row.ItemArray[2],2}");
                formattedLine.Append($"{row.ItemArray[3].ToString().Substring(0,8),-8}");
                formattedLine.Append($"{row.ItemArray[4].ToString().Substring(0,10),-10}");
                formattedLine.Append($"{row.ItemArray[5].ToString().Substring(0,4)}");
                formattedLine.Append($"{row.ItemArray[6],1}");
                formattedLine.Append($"{row.ItemArray[7].ToString().PadLeft(5,'0')}");

                lines.Add(formattedLine.ToString());
            }
            
            System.IO.File.WriteAllLines(@"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\transins.dat", lines);

            // Execute PowerShell script that runs COBOL programs
            var psScript = new StringBuilder();
            
            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os";
            psScript.AppendLine($"$WorkingDir = \"{path}\"");
            psScript.AppendLine("$CurrMasterDataFile = Join-Path $WorkingDir \"\\data\\students.dat\"");
            psScript.AppendLine("$fileExist = Test-Path $CurrMasterDataFile");
            psScript.AppendLine("if ($fileExist) {Remove-Item $CurrMasterDataFile}");
            psScript.AppendLine("$OrigMasterDataFile = Join-Path $WorkingDir \"\\data\\students_orig.dat\"");
            psScript.AppendLine("$DestinationFile = Join-Path $WorkingDir \"\\data\\students.dat\"");
            psScript.AppendLine("Copy-Item $OrigMasterDataFile -Destination $DestinationFile");
            psScript.AppendLine("$Executable = Join-Path $WorkingDir \"\\studentwrite.exe\"");
            psScript.AppendLine("& $Executable");

            // remove students.dat file and rename students1.dat
            psScript.AppendLine("Remove-Item $CurrMasterDataFile");
            psScript.AppendLine("$NewMasterDataFile = Join-Path $WorkingDir \"\\data\\students1.dat\"");
            psScript.AppendLine("Rename-Item -Path $NewMasterDataFile -NewName \"students.dat\"");

            List<string> results = RunScript(psScript.ToString());
            tbExecResults.Clear();
            foreach (var result in results)
                tbExecResults.AppendText(result);
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

        private void bnRefreshData_Click(object sender, EventArgs e)
        {
            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat";
            var recs = new StudentRecords(path);
            var allrecs = recs.GetAllRecords();

            ds.Tables[0].Rows.Clear();
            foreach (var rec in allrecs)
                ds.Tables[0].Rows.Add(rec.StudentId,
                                        rec.LastName,
                                        rec.Initials,
                                        rec.DOB,
                                        rec.PhoneNo,
                                        rec.ProgramCode,
                                        rec.Gender,
                                        rec.LoanAmount);
            ds.Tables[0].AcceptChanges();
            //dgvStudentRecords.DataSource = ds.Tables[0];
        }

        private bool IsRepeatedCellValue(int rowIndex, int colIndex)
        {
            DataGridViewCell currCell = dgvStudentRecords.Rows[rowIndex].Cells[colIndex];
            DataGridViewCell prevCell = dgvStudentRecords.Rows[rowIndex - 1].Cells[colIndex];

            if (colIndex > 0)
                return false;
            
            if ((currCell.Value == prevCell.Value) ||
                (currCell.Value != null && prevCell.Value != null &&
                currCell.Value.ToString() == prevCell.Value.ToString()))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        

        private void dgvStudentRecords_CellFormatting(object sender, DataGridViewCellFormattingEventArgs args)
        {
            // Call home to base
            //base.OnCellFormatting(args);

            // First row always displays
            if (args.RowIndex == 0)
                return;
            
            if (IsRepeatedCellValue(args.RowIndex, args.ColumnIndex))
            {
                args.Value = string.Empty;
                args.FormattingApplied = true;
            }
        }

        private void dgvStudentRecords_CellPainting(object sender, DataGridViewCellPaintingEventArgs args)
        {
            //base.OnCellPainting(args);
            args.AdvancedBorderStyle.Bottom = DataGridViewAdvancedCellBorderStyle.None;

            // Ignore column and row headers and first row
            if (args.RowIndex < 1 || args.ColumnIndex < 0)
                return;

            if (IsRepeatedCellValue(args.RowIndex, args.ColumnIndex))
            {
                args.AdvancedBorderStyle.Top = DataGridViewAdvancedCellBorderStyle.None;
            }
            else
            {
                args.AdvancedBorderStyle.Top = dgvStudentRecords.AdvancedCellBorderStyle.Top;
            }
        }
    }
}
