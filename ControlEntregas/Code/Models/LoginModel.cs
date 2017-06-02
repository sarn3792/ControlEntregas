using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.DirectoryServices;

namespace ControlEntregas.Code
{
    public class LoginModel
    {
        public bool ValidateLogin(Login info)
        {
            try
            {
                String domain = System.Configuration.ConfigurationManager.AppSettings["DirectoryDomain"];
                String path = System.Configuration.ConfigurationManager.AppSettings["DirectoryPath"];

                String domainAndUserName = domain + @"\" + info.user;

                DirectoryEntry entry = new DirectoryEntry(path, domainAndUserName, info.password);
                Object obj = entry.NativeObject;
                DirectorySearcher search = new DirectorySearcher(entry);
                search.Filter = "(SAMAccountName=" + info.user + ")";
                search.PropertiesToLoad.Add("cn");
                SearchResult result = search.FindOne();
                if (null == result)
                {
                    return false;
                }
                // Update the new path to the user in the directory
                path = result.Path;
                string _filterAttribute = (String)result.Properties["cn"][0];

                return true;
            }
            catch (System.DirectoryServices.DirectoryServicesCOMException ex)
            {
                return false;
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        } 
    }
}