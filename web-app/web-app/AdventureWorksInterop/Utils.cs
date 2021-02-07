using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace web_app.AdventureWorksInterop
{
    public static class Utils
    {
        public static string GetConnectionStringOrDefault(string defaultNameOrConnectionString)
        {
            var connectionStringFromEnvironment = Environment.GetEnvironmentVariable("ConnectionStrings:AdventureWorksLT2019");

            System.Diagnostics.Debug.WriteLine($"ConnectionStrings:AdventureWorksLT2019 = {connectionStringFromEnvironment}");

            string connectionStringFromSettings = defaultNameOrConnectionString;

            ConnectionStringSettingsCollection settings = ConfigurationManager.ConnectionStrings;

            if (settings != null)
            {
                foreach (ConnectionStringSettings cs in settings)
                {
                    Console.WriteLine(cs.Name);
                    Console.WriteLine(cs.ProviderName);
                    Console.WriteLine(cs.ConnectionString);

                    if (defaultNameOrConnectionString.Equals(cs.Name, StringComparison.InvariantCultureIgnoreCase))
                    {
                        connectionStringFromSettings = cs.ConnectionString;
                    }
                }
            }

            return String.IsNullOrEmpty(connectionStringFromEnvironment) ? connectionStringFromSettings : connectionStringFromEnvironment;
        }
    }
}