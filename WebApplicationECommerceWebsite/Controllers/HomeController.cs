using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.VisualStudio.Services.UserAccountMapping;
using PagedList;
using WebApplicationECommerceWebsite.Models;
using WebApplicationECommerceWebsite.Models.ViewModel;

namespace WebApplicationECommerceWebsite.Controllers
{
   
    public class HomeController : Controller
    {
        E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ProductList(string search, int? page, int id = 0)
        {

            if (id != 0)
            {

                return View(db.tblProducts.Where(p => p.CategoryId == id).ToList().ToPagedList(page ?? 1, 4));
            }
            else
            {
                if (search != "")
                {
                    return View(db.tblProducts.Where(x => x.Description.Contains(search) || x.ProductName.Contains(search) || search == null).ToList().ToPagedList(page ?? 1, 4));
                }
                else
                {
                    return View(db.tblProducts.ToList().ToPagedList(page ?? 1, 4));
                }

            }

        }
        public ActionResult Signup()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Signup(UserViewModel uv)
        {
            tblUser tbl = db.tblUsers.Where(u => u.UserName == uv.UserName).FirstOrDefault();
            if (tbl != null)
            {
                return Json(new { success = false, message = "User Already Register" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                tblUser tb = new tblUser();
                tb.UserName = uv.UserName;
                tb.Password = uv.Password;
                tb.Fullname = uv.FullName;
                tb.Email = uv.Email;
                db.tblUsers.Add(tb);
                db.SaveChanges();

                tblUserRole ud = new tblUserRole();
                ud.UserId = tb.UserId;
                ud.RoleId = 2;
                db.tblUserRoles.Add(ud);
                db.SaveChanges();
                return Json(new { success = true, message = "User Register Successfully" }, JsonRequestBehavior.AllowGet);
            }



        }
   
        public ActionResult ViewItem(int id)
        {
            return PartialView("_ViewItem", db.tblProducts.Find(id));
        }


    }
}