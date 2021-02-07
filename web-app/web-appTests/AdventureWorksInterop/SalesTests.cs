using Microsoft.VisualStudio.TestTools.UnitTesting;
using web_app.AdventureWorksInterop;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace web_app.AdventureWorksInterop.Tests
{
    [TestClass()]
    public class SalesTests
    {
        [TestMethod()]
        public void GetCustomersTest()
        {
            try
            {
                var sales = new Sales();
                var customers = sales.GetCustomers();

                Assert.IsNotNull(customers, "Customers shouldn't be null");
            }
            catch (System.Runtime.InteropServices.COMException ex)
            {
                Assert.Fail(ex.Message);
            }
            catch (Exception ex)
            {
                Assert.Fail(ex.Message);
            }
        }
    }
}