using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using web_app.AdventureWorksInterop.Models;

namespace web_app.AdventureWorksInterop
{
    public class Sales
    {
        public List<Customer> GetCustomers()
        {
            try
            {
                var connectionString = Utils.GetConnectionStringOrDefault("AdventureWorksLT2019");

                // dynamic create object
                Type salesType = Type.GetTypeFromProgID("AdventureWorksLT.Sales");
                if (salesType == null)
                {
                    throw new NullReferenceException("Component AdventureWorksLT.Sales not registered");
                }

                dynamic salesInst = Activator.CreateInstance(salesType);
                var json = salesInst.GetCustomers(ref connectionString) as string;

                if (String.IsNullOrEmpty(json))
                {
                    return null;
                }

                var customers = JsonConvert.DeserializeObject<List<Customer>>(json);

                return customers?.Where(c => c != null).ToList();
            }
            catch (Exception ex)
            {
                // log the exception and re-throw
                System.Diagnostics.Debug.WriteLine(ex.Message);
                throw;
            }
        }
    }
}