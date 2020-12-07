using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplicationECommerceWebsite.Models
{

    public static class ItemDB
    {
       
        public static List<tblProduct> GetAllSpecialItem()
        {
            using (var context = new E_CommerceWebsiteEntities())
            {
                return context.tblProducts.Where(a => a.IsSpecial == true).Take(4).ToList();
            }


        }

        public static List<tblProduct> GetAllItem()
        {
            using (var context = new E_CommerceWebsiteEntities())
            {
                return context.tblProducts.Take(4).ToList();
            }


        }
    }
}