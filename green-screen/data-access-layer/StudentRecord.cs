using System;
using System.Numerics;

namespace data_access_layer
{
    public class StudentRecord
    {
        public string StudentId { get; set; }
        public string FullName { get; set; }
        public string DOB { get; set; }
        public string ProgramCode { get; set; }
        public char Gender { get; set; }
        public string PhoneNo { get; set; }
        public int LoanAmount { get; set; }
    }
}
