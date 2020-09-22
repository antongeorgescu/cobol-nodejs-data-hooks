using data_access_layer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
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

        private void Dashboard_Load(object sender, EventArgs e)
        {
            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat";
            var recs = new StudentRecords(path);
            var allrecs = recs.GetAllRecords();


            dgvStudentRecords.Columns.Add("studentId", "Student ID");
            dgvStudentRecords.Columns.Add("lastName", "Last Name");
            dgvStudentRecords.Columns.Add("initials", "Initials");
            dgvStudentRecords.Columns.Add("dob", "DOB");
            dgvStudentRecords.Columns.Add("programCode", "Program Code"); 
            dgvStudentRecords.Columns.Add("gender", "Gender");
            dgvStudentRecords.Columns.Add("phoneNo", "Phone");
            dgvStudentRecords.Columns.Add("loanAmount", "Loan ($)");
            foreach (var rec in allrecs)
                dgvStudentRecords.Rows.Add(rec.StudentId,
                                            rec.LastName,
                                            rec.Initials,
                                            rec.ProgramCode,
                                            rec.DOB,
                                            rec.Gender,
                                            rec.PhoneNo,
                                            rec.LoanAmount);
        }
    }
}
