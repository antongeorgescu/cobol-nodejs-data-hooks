using System;
using System.Collections.Generic;
using System.Text;

namespace data_access_layer
{
    public class StudentRecords
    {
        List<StudentRecord> allRecords;

        public List<StudentRecord> GetAllRecords() {
            return null;
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
