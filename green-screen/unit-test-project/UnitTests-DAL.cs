using System;
using data_access_layer;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace unit_test_project
{
    [TestClass]
    public class UnitTestDAL
    {
        [TestMethod]
        public void TestMethod1()
        {
            var path = @"C:\Users\ag4488\Documents\Visual Studio 2019\Projects\cobol-nodejs-data-hooks\cobol-os\data\students.dat";
            var recs = new StudentRecords(path);
            var allrecs = recs.GetAllRecords();
            Assert.IsTrue(allrecs.Count > 0);
        }
    }
}
