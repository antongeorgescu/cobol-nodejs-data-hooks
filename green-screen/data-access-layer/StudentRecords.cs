using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace data_access_layer
{
    public class StudentRecords
    {
        List<StudentRecord> allRecords;
        List<string> allLines;

        public StudentRecords(string path)
        {
            allLines = File.ReadAllLines(path).ToList<string>(); //.OrderByDescending(x => int.Parse(x));
        }
        public List<StudentRecord> GetAllRecords() {
            allRecords = new List<StudentRecord>();
            foreach (var line in allLines)
            {
                allRecords.Add(new StudentRecord()
                {
                    StudentId = line.Substring(0, 7),
                    LastName = line.Substring(7, 8),
                    Initials = line.Substring(15, 2),
                    DOB = line.Substring(17, 8),
                    PhoneNo = line.Substring(25, 10),
                    ProgramCode = line.Substring(35, 4),
                    Gender = line.Substring(39, 1).ToCharArray()[0],
                    LoanAmount = int.Parse(line.Substring(40, 5))
                });
            }
            //allRecords = (List<StudentRecord>)allRecords.OrderByDescending(x => int.Parse(x.StudentId));
            allRecords.Sort((a,b) => (int.Parse(b.StudentId)).CompareTo(int.Parse(a.StudentId)));

            KeepLastOfDuplicates(ref allRecords);

            return allRecords;
        }

        private void KeepLastOfDuplicates(ref List<StudentRecord> allRecords)
        {
            var count = allRecords.Count;
            return;
        }

        public void AddRecord(StudentRecord aRecord)
        {
            allRecords.Add(aRecord);
        }

        public void UpdateRecord(string studentId, StudentRecord aRecord)
        {
            return;

        }
    }
}
