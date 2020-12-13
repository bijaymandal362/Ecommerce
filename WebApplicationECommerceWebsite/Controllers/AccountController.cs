using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebApplicationECommerceWebsite.Models;
using WebApplicationECommerceWebsite.Models.ViewModel;

namespace WebApplicationECommerceWebsite.Controllers
{
    public class AccountController : Controller
    {
        E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities();
        // GET: Account
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Models.ViewModel.LoginViewModel iv, string ReturnUrl = "")
        {
            using (E_CommerceWebsiteEntities db = new E_CommerceWebsiteEntities())
            {
                var user = db.tblUsers.Where(a => a.UserName == iv.UserName && a.Password == iv.Password).FirstOrDefault();
                if (user != null)
                {
                    Session.Add("FullName", user.Fullname);
                    Session.Add("UserName", user.UserName);
                    FormsAuthentication.SetAuthCookie(iv.UserName, iv.RememberMe);
                    if (Url.IsLocalUrl(ReturnUrl))
                    {
                        return Redirect(ReturnUrl);
                    }
                    else
                    {
                        if (user.tblUserRoles.Where(r => r.RoleId == 1).FirstOrDefault() != null)
                        {
                            return RedirectToAction("Dashboard", "Admin");
                        }
                        else
                        {
                            return RedirectToAction("Index", "Home");
                        }

                    }

                }
                else
                {
                    ModelState.AddModelError("", "Invalid User");
                }
                return View();
            }
        }
        [Authorize]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Session.Clear();
            return RedirectToAction("Login", "Account");

        }
        [Authorize]
        public ActionResult ChangePassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordViewModel cp)
        {

            string username = Session["UserName"].ToString();
            var user = db.tblUsers.Where(a => a.UserName == username).FirstOrDefault();
            if (user != null)
            {
                if (user.Password == cp.OldPassword)
                {
                    if (cp.NewPassword == cp.ConfirmNew)
                    {
                        user.Password = cp.NewPassword;
                        db.SaveChanges();
                        ViewBag.Message = "Password Changed";

                    }
                    else
                    {
                        ViewBag.Message = "New Password and Confirm New Mismatched";
                    }
                }
                else
                {
                    ViewBag.Message = "Wrong Password";
                }



            }

            return View();
        }
        public ActionResult ForgetPassword()
        {
            return View();
        }
        [HttpPost]
        [ValidateOnlyIncomingValuesAttribute]
        public ActionResult ForgetPassword(UserViewModel fp)
        {
            var user = db.tblUsers.Where(a => a.Email == fp.Email).FirstOrDefault();
            if (user != null)
            {
                try
                {
                    MailMessage mail = new MailMessage();
                    SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                    mail.From = new MailAddress("dotnetgroup789@gmail.com");
                    mail.To.Add(user.Email);
                    mail.Subject = "Password Recovery Sent From Sachin";
                    mail.Body = "<b>Password </b>:" + user.Password;
                    mail.IsBodyHtml = true;
                    SmtpServer.Port = 587;
                    SmtpServer.Credentials = new System.Net.NetworkCredential("dotnetgroup789@gmail.com", "Dotnet123");
                    SmtpServer.EnableSsl = true;
                    ViewBag.Message = "Mail Sending";

                    SmtpServer.Send(mail);
                    ViewBag.Message = "Mail Sent";
                }
                catch (Exception ex)
                {
                    ViewBag.Message = "Email Sending Failed" + ex.ToString();
                }

            }
            else
            {
                ViewBag.Message = "Invalid Email";
            }
            return View();
        }
    }
}