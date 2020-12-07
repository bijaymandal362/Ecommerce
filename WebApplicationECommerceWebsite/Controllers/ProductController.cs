using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplicationECommerceWebsite.Models;
using WebApplicationECommerceWebsite.Models.ViewModel;

namespace WebApplicationECommerceWebsite.Controllers
{
    public class ProductController : Controller
    {
        E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities();
        // GET: Product
        public ActionResult ManageProduct()
        {
            return View();
        }
        public JsonResult GetData()
        {
            db.Configuration.LazyLoadingEnabled = false;
            List<ProductViewModel> lst = new List<ProductViewModel>();
            var Product = db.tblProducts.Include("tblCategory").ToList();
            foreach (var item in Product)
            {
                lst.Add(new ProductViewModel() { ProductId = item.ProductId, CategoryName = item.tblCategory.CategoryName ,ProductName=item.ProductName , UnitPrice=item.UnitPrice,SellingPrice=item.SellingPrice,Photo=item.Photo });
            }

            return Json(new { data = lst }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AddEdit(int id = 0)
        {
            if (id == 0)
            {
                ViewBag.Categories = db.tblCategories.ToList();
                ViewBag.Action = "New Product";
                return View(new ProductViewModel());
            }
            else
            {
                tblProduct product = db.tblProducts.Where(a => a.ProductId == id).FirstOrDefault();
                ProductViewModel pv = new ProductViewModel();
                pv.ProductId = product.ProductId;
                pv.ProductName = product.ProductName;
                pv.CategoryId = product.CategoryId;
                pv.UnitPrice = product.UnitPrice;
                pv.SellingPrice = product.SellingPrice;
                pv.Description = product.Description;
                pv.IsSpecial = product.IsSpecial;
                pv.Photo = product.Photo;
                ViewBag.Action = "Edit Product";
                ViewBag.Categories = db.tblCategories.ToList();
                return View(pv);

            }
        }

        [HttpPost]
        public ActionResult AddEdit(ProductViewModel pvm)
        {
            if (pvm.ProductId > 0)
            {
                tblProduct tb = db.tblProducts.Where(x => x.ProductId == pvm.ProductId).FirstOrDefault();
                tb.ProductName =pvm.ProductName;
                tb.CategoryId =pvm.CategoryId;
                tb.UnitPrice =pvm.UnitPrice;
                tb.SellingPrice=pvm.SellingPrice;
                tb.Description=pvm.Description;
                tb.IsSpecial = pvm.IsSpecial;
                HttpPostedFileBase fup = Request.Files["Photo"];
                if (fup!=null)
                {
                    if (fup.FileName!="")
                    {
                        System.IO.File.Delete(Server.MapPath("~/ProductImages/" + tb.Photo));
                        tb.Photo = fup.FileName;
                        fup.SaveAs(Server.MapPath("~/ProductImages/" + fup.FileName));

                    }
                    else
                    {
                        tb.Photo = fup.FileName;
                        fup.SaveAs(Server.MapPath("~/ProductImages/" + fup.FileName));
                    }

                }
                db.SaveChanges();
                ViewBag.Categories = db.tblCategories.ToList();
                return RedirectToAction("ManageProduct");
            }
            else
            {
                tblProduct tb = new tblProduct();
                tb.ProductName = pvm.ProductName;
                tb.CategoryId = pvm.CategoryId;
                tb.UnitPrice = pvm.UnitPrice;
                tb.SellingPrice = pvm.SellingPrice;
                tb.Description = pvm.Description;
                tb.IsSpecial = pvm.IsSpecial;
                HttpPostedFileBase fup = Request.Files["Photo"];
                if (fup != null)
                {
                   tb.Photo = fup.FileName;
                   fup.SaveAs(Server.MapPath("~/ProductImages/" + fup.FileName));
                }

                db.tblProducts.Add(tb);
                db.SaveChanges();
                ViewBag.Categories = db.tblCategories.ToList();
                return RedirectToAction("ManageProduct");
            }
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {


            tblProduct tbl = db.tblProducts.Where(a => a.ProductId == id).FirstOrDefault();
            if (tbl.Photo != "")
            {
                System.IO.File.Delete(Server.MapPath("~/ProductImages/" + tbl.Photo));
            }

            db.tblProducts.Remove(tbl);
            db.SaveChanges();
           

            return Json(new { success = true, message = "Deleted Sucessfully" }, JsonRequestBehavior.AllowGet);
        }

     
    }
}