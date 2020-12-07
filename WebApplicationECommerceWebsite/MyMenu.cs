using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplicationECommerceWebsite.Models;

namespace WebApplicationECommerceWebsite
{
    public static class MyMenu
    {
        public static List<tblCategory> GetMenus()
        {
            
                using (var context = new E_CommerceWebsiteEntities())
                {
                    return context.tblCategories.ToList();
                }


            }

          
        }
    }
