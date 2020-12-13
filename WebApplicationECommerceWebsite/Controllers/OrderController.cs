using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplicationECommerceWebsite.Models;
using WebApplicationECommerceWebsite.Models.ViewModel;

namespace WebApplicationECommerceWebsite.Controllers
{
    public class OrderController : Controller
    {
        // GET: Order
        public ActionResult ManageOrder()
        {
            return View();
        }
        public JsonResult GetData()
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {
                db.Configuration.LazyLoadingEnabled = false;
                List<OrderViewModel> lstorder = new List<OrderViewModel>();
                var empList = db.tblOrders.Select(x => new { OrderId = x.OrderId, Firstname = x.Firstname, Lastname = x.Lastname, Address = x.Address, Phone = x.Phone, Total = x.Total, OrderDate = x.OrderDate, DeliveredStatus = x.DeliveredStatus }).ToList();
                foreach (var item in empList)
                {
                    lstorder.Add(new OrderViewModel() { OrderId = item.OrderId, Firstname = item.Firstname, Lastname = item.Lastname, Address = item.Address, Phone = item.Phone, Total = item.Total.ToString(), OrderDate = item.OrderDate.ToString(), DeliveredStatus = item.DeliveredStatus });
                }
                return Json(new { data = lstorder }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpGet]

        public ActionResult ViewOrder(int id)
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {

                List<OrderDetailsViewModel> lstod = new List<OrderDetailsViewModel>();
                var empList = db.tblOrderDetails.Where(x => x.OrderId == id).ToList();
                foreach (tblOrderDetail item in empList)
                {
                    lstod.Add(new OrderDetailsViewModel() { ItemId = Convert.ToInt32(item.ProductId), ItemName = item.tblProduct.ProductName, Quantity = Convert.ToInt32(item.Quantity), UnitPrice = Convert.ToDecimal(item.UnitPrice) });
                }
                Session.Add("itemlist", lstod);
                Session.Add("orderid", id);
                return View(lstod);
            }
        }
        [HttpPost, ActionName("ViewOrder")]
        public ActionResult ViewOrder_Post(int id)
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {

                tblOrder sm = db.tblOrders.Where(x => x.OrderId == id).FirstOrDefault();
                sm.DeliveredStatus = "Confirmed";





                db.SaveChanges();
                return RedirectToAction("ManageOrder", "Order");
            }

        }
       

        [HttpPost]

        public ActionResult Delete(int id)
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {
                tblOrder sm = db.tblOrders.Where(x => x.OrderId == id).FirstOrDefault();
                db.tblOrders.Remove(sm);
                db.SaveChanges();
                return Json(new { success = true, message = "Deleted Successfully" }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}