using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplicationECommerceWebsite.Models;
using WebApplicationECommerceWebsite.Models.ViewModel;

namespace WebApplicationECommerceWebsite.Controllers
{
    public class ManageUserController : Controller
    {
        // GET: ManageUser
        public ActionResult ManageUser()
        {
            return View();
        }
        public JsonResult GetData()
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {
                db.Configuration.LazyLoadingEnabled = false;
                List<UserViewModel> lstitem = new List<UserViewModel>();
                var lst = db.tblUsers.ToList();
                foreach (var item in lst)
                {
                    lstitem.Add(new UserViewModel() { UserId = item.UserId, UserName = item.UserName, FullName = item.Fullname, Email = item.Email });
                }
                return Json(new { data = lstitem }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult AddOrEdit()
        {
            return View();
        }
        [HttpPost]

        public ActionResult AddOrEdit(UserViewModel uv)
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
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
                ud.RoleId = 1;
                db.tblUserRoles.Add(ud);
                db.SaveChanges();
                ViewBag.Message = "User Created Successfully";


                return RedirectToAction("ManageUser");
            }
        }
        [HttpPost]

        public ActionResult Delete(int id)
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {
                tblUser sm = db.tblUsers.Where(x => x.UserId == id).FirstOrDefault();
                db.tblUsers.Remove(sm);
                db.SaveChanges();
                return Json(new { success = true, message = "Deleted Successfully" }, JsonRequestBehavior.AllowGet);
            }
        }
    }
    }
    