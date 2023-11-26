using templedunia.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace templedunia.Controllers
{

    public class AdminController : Controller
    {
        templeduniaEntities db = new templeduniaEntities();

        public ActionResult Index()
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            ViewBag.TempleListingCount = db.TempleListings.Count();
            ViewBag.ContactEnquiresCount = db.ContactEnquires.Count();
            return View();
        }

        public ActionResult ContactEnquiry()
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            ViewBag.Enquiry = db.ContactEnquires.ToList();
            return View();
        }

        public ActionResult AddTemple()
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            List<State> stateList = db.States.ToList();
            ViewBag.stateList = new SelectList(stateList, "StateId", "StateName");
            TempleListing temple = new TempleListing();
            ViewBag.AllTemple = db.TempleListings.ToList();
            return View(temple);
        }
        [HttpPost]
        public ActionResult AddTemple(TempleListing temple, HttpPostedFileBase image1, HttpPostedFileBase image2, HttpPostedFileBase image3, HttpPostedFileBase image4)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            if (ModelState.IsValid)
            {
                if (image1 != null && image1.ContentLength > 0)
                {
                    temple.image1 = image1.FileName;
                    TempleImageProcess(image1.InputStream, image1.FileName);
                }

                if (image2 != null && image2.ContentLength > 0)
                {
                    temple.image2 = image2.FileName;
                    TempleImageProcess(image2.InputStream, image2.FileName);
                }

                if (image3 != null && image3.ContentLength > 0)
                {
                    temple.image3 = image3.FileName;
                    TempleImageProcess(image3.InputStream, image3.FileName);
                }
                if (image4 != null && image4.ContentLength > 0)
                {
                    temple.image4 = image4.FileName;
                    TempleImageProcess(image4.InputStream, image4.FileName);
                }

                temple.rts = DateTime.Now;
                temple.status = true;
                db.TempleListings.Add(temple);
                db.SaveChanges();
            }
            return RedirectToAction("AddTemple", "Admin");
        }

        public ActionResult EditTemple(int id)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            var temple = db.TempleListings.Single(x => x.Id == id);

            List<State> StateList = db.States.ToList();
            ViewBag.StateList = new SelectList(db.States.ToList().Select(x => new { StateId = x.StateId, StateName = x.StateName }), "StateId", "StateName", temple.sid);

            List<District> DistrictList = db.Districts.ToList();
            ViewBag.DistrictList = new SelectList(db.Districts.ToList().Select(x => new { DistrictId = x.DistrictId, DistrictName = x.DistrictName }), "DistrictId", "DistrictName", temple.did);

            List<City> TehsileList = db.Cities.ToList();
            ViewBag.TehsileList = new SelectList(db.Cities.ToList().Select(x => new { CityId = x.CityId, CityName = x.CityName }), "CityId", "CityName", temple.cid);

            return View(temple);
        }

        [HttpPost]
        public ActionResult EditTemple(TempleListing temple, HttpPostedFileBase image1, HttpPostedFileBase image2, HttpPostedFileBase image3, HttpPostedFileBase image4)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            if (ModelState.IsValid)
            {
                if (image1 != null && image1.ContentLength > 0)
                {
                    temple.image1 = image1.FileName;
                    TempleImageProcess(image1.InputStream, image1.FileName);
                }

                if (image2 != null && image2.ContentLength > 0)
                {
                    temple.image2 = image2.FileName;
                    TempleImageProcess(image2.InputStream, image2.FileName);
                }

                if (image3 != null && image3.ContentLength > 0)
                {
                    temple.image3 = image3.FileName;
                    TempleImageProcess(image3.InputStream, image3.FileName);
                }
                if (image4 != null && image4.ContentLength > 0)
                {
                    temple.image4 = image4.FileName;
                    TempleImageProcess(image4.InputStream, image4.FileName);
                }
            }
            db.Entry(temple).State = EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("EditTemple", "Admin");
        }

        public ActionResult ChangeToActive(int id)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            TempleListing temple = db.TempleListings.Single(x => x.Id == id);
            temple.status = true;
            db.SaveChanges();
            return RedirectToAction("AddTemple");
        }

        public ActionResult ChangeToDeactive(int id)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            TempleListing temple = db.TempleListings.Single(x => x.Id == id);
            temple.status = false;
            db.SaveChanges();
            return RedirectToAction("AddTemple");
        }

        public ActionResult DeleteTemple(int id)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            db.TempleListings.Remove(db.TempleListings.Where(x => x.Id == id).SingleOrDefault());
            db.SaveChanges();
            return RedirectToAction("AddTemple");
        }
        private void TempleImageProcess(Stream stream, string fname)
        {
            using (var photo = new Bitmap(stream))
            {
                using (var bmp1 = new Bitmap(photo, 1000, 667))
                {
                    var encoderParameters = new EncoderParameters(1)
                    {
                        Param = new EncoderParameter[] { new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 90L) }
                    };

                    bmp1.Save(Server.MapPath($"~/Content/assets/Images/TempleImages/{fname}"), ImageCodecInfo.GetImageDecoders().FirstOrDefault(codec => codec.FormatID == ImageFormat.Jpeg.Guid), encoderParameters);
                }
            }
        }
        public ActionResult AddArticle()
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            ViewBag.AllArticle = db.Blog_Table.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult AddArticle(Blog_Table model, HttpPostedFileBase blogImage)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }

            if (ModelState.IsValid && blogImage != null && blogImage.ContentLength > 0)
            {
                model.blogImage = blogImage.FileName;
                ArticleImageProcess(blogImage.InputStream, blogImage.FileName);
            }
            model.blogRTS = DateTime.Now.ToString();
            model.blogStatus = "1";
            db.Blog_Table.Add(model);
            db.SaveChanges();

            return RedirectToAction("AddArticle");
        }

        public ActionResult EditArticle(int id)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            Blog_Table blog = db.Blog_Table.Single(x => x.Id == id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            return View("EditArticle", blog);
        }

        [HttpPost]
        public ActionResult EditArticle(Blog_Table model, HttpPostedFileBase blogImage)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            if (ModelState.IsValid)
            {
                if (blogImage != null && blogImage.ContentLength > 0)
                {
                    model.blogImage = blogImage.FileName;
                    ArticleImageProcess(blogImage.InputStream, blogImage.FileName);
                }
            }
            db.Entry(model).State = EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("AddArticle", "Admin");
        }

        public ActionResult DeleteArticle(int id)
        {
            if (Session["userid"] == null)
            {
                return RedirectToAction("Login");
            }
            db.Blog_Table.Remove(db.Blog_Table.Where(x => x.Id == id).SingleOrDefault());
            db.SaveChanges();
            return RedirectToAction("AddArticle");
        }
        private void ArticleImageProcess(Stream stream, string fname)
        {
            using (var photo = new Bitmap(stream))
            {
                using (var bmp1 = new Bitmap(photo, 800, 532))
                {
                    var encoderParameters = new EncoderParameters(1)
                    {
                        Param = new EncoderParameter[] { new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 90L) }
                    };

                    bmp1.Save(Server.MapPath($"~/Content/assets/Images/ArticleImages/{fname}"), ImageCodecInfo.GetImageDecoders().FirstOrDefault(codec => codec.FormatID == ImageFormat.Jpeg.Guid), encoderParameters);
                }
            }
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Admin_Login login)
        {
            if (ModelState.IsValid)
            {
                var model = db.Admin_Login.FirstOrDefault(m => m.Username == login.Username && m.UserPassword == login.UserPassword);
                if (model != null)
                {
                    Session["username"] = model.Username;
                    Session["userid"] = model.Id;
                    return Json(new { success = true });
                }
            }

            return Json(new { success = false });
        }

        public ActionResult Logout()
        {
            Session["username"] = "";
            Session["userid"] = "";
            Session.Clear();
            return RedirectToAction("Login");
        }

        public JsonResult DistrictList(int Id)
        {
            var categories = (from b in db.Districts where b.StateId == Id select b).ToList();
            return Json(new SelectList(categories, "DistrictId", "DistrictName"), JsonRequestBehavior.AllowGet);
        }
        public JsonResult TehsilList(int Id)
        {
            var categorieslist = (from c in db.Cities where c.DistrictId == Id select c).ToList();
            return Json(new SelectList(categorieslist, "CityId", "CityName"), JsonRequestBehavior.AllowGet);
        }
    }
}