using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplicationECommerceWebsite.Models;
using WebApplicationECommerceWebsite.Models.ViewModel;

namespace WebApplicationECommerceWebsite.Controllers
{
    public class CategoryController : Controller
    {
        E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities();
        // GET: Category
        public ActionResult ManageCategory()
        {
            return View();
        }
        public JsonResult ListData()
        {
            db.Configuration.LazyLoadingEnabled = false;
            List<CategoryViewModel> lst = new List<CategoryViewModel>();
            var category = db.tblCategories.ToList();
            foreach (var item in category)
            {
                lst.Add(new CategoryViewModel() {CategoryId=item.CategoryId, CategoryName = item.CategoryName });
            }
           
            return Json(new { data=lst},JsonRequestBehavior.AllowGet);
        }

        public ActionResult AddEdit(int id = 0)
        {
            if (id == 0)
            {
                ViewBag.Action = "New Category";
                return PartialView("AddEdit");
            }
            else
            {
                var category = db.tblCategories.Where(a => a.CategoryId == id).FirstOrDefault();
                CategoryViewModel cv = new CategoryViewModel();
                cv.CategoryId = category.CategoryId;
                cv.CategoryName = category.CategoryName;
                ViewBag.Action = "Edit Category";
                return PartialView("AddEdit", cv);

            }
        }

        [HttpPost]
        public JsonResult AddEdit(CategoryViewModel pvm)
        {
            if (pvm.CategoryId > 0)
            {
                tblCategory tb = db.tblCategories.Where(x => x.CategoryId == pvm.CategoryId).FirstOrDefault();
                tb.CategoryName = pvm.CategoryName;
                db.SaveChanges();
                return Json(new { success = true, message = "Updated Successfully" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                tblCategory tb = new tblCategory();
                tb.CategoryName = pvm.CategoryName;
                db.tblCategories.Add(tb);
                db.SaveChanges();
                return Json(new { success = true, message = "Saved Successfully" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            tblCategory tbl = db.tblCategories.Where(a => a.CategoryId == id).FirstOrDefault();
            db.tblCategories.Remove(tbl);
            db.SaveChanges();

            return Json(new { success = true, message = "Deleted Sucessfully" }, JsonRequestBehavior.AllowGet);
        }
    }
    }
