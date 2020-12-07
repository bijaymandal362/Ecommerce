using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebApplicationECommerceWebsite.Models.ViewModel
{
    public class CategoryViewModel
    {
        public int CategoryId { get; set; }
       [Required (ErrorMessage ="Insert Category Name")]
        public string CategoryName { get; set; }
        
    }
}