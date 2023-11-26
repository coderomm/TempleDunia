using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using templedunia.Models;

namespace templedunia.Controllers
{
    public class HomeController : Controller
    {
        templeduniaEntities db = new templeduniaEntities();

        public ActionResult Index()
        {
            var temple = db.TempleListings.OrderBy(x => Guid.NewGuid()).ToList();
            var states = db.States.ToList();
            var districts = db.Districts.ToList();
            var cities = db.Cities.ToList();

            ViewBag.slist = temple.ToDictionary(templeitem => templeitem.Id, templeitem => states.Where(x => x.StateId == templeitem.sid).ToList());
            ViewBag.dlist = temple.ToDictionary(templeitem => templeitem.Id, templeitem => districts.Where(x => x.DistrictId == templeitem.did).ToList());
            ViewBag.clist = temple.ToDictionary(templeitem => templeitem.Id, templeitem => cities.Where(x => x.CityId == templeitem.cid).ToList());

            foreach (var templeitem in temple)
            {
                const int maxLines = 1;
                const int maxWordsPerLine = 20;

                var lines = templeitem.detail.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var truncatedLines = lines.Take(maxLines);

                foreach (var line in truncatedLines)
                {
                    var words = line.Split(' ');
                    var truncatedWords = words.Take(maxWordsPerLine);
                    var truncatedLine = string.Join(" ", truncatedWords);

                    if (words.Length > maxWordsPerLine)
                    {
                        truncatedLine += " ...";
                    }

                    templeitem.detail = truncatedLine;
                    break;
                }

            }

            var article = db.Blog_Table.OrderBy(x => Guid.NewGuid()).ToList();

            foreach (var articleitem in article)
            {
                const int maxLines = 1;
                const int maxWordsPerLine = 15;

                var lines = articleitem.blogDetail.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var truncatedLines = lines.Take(maxLines);

                foreach (var line in truncatedLines)
                {
                    var words = line.Split(' ');
                    var truncatedWords = words.Take(maxWordsPerLine);
                    var truncatedLine = string.Join(" ", truncatedWords);

                    if (words.Length > maxWordsPerLine)
                    {
                        truncatedLine += " ...";
                    }

                    articleitem.blogDetail = truncatedLine;
                    break;
                }
            }

            ViewBag.allarticles = article;

            return View(temple);
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult TempleListing()
        {
            var temple = db.TempleListings.OrderBy(x => Guid.NewGuid()).ToList();
            var states = db.States.ToList();
            var districts = db.Districts.ToList();
            var cities = db.Cities.ToList();

            ViewBag.slist = temple.ToDictionary(templeitem => templeitem.Id, templeitem => states.Where(x => x.StateId == templeitem.sid).ToList());
            ViewBag.dlist = temple.ToDictionary(templeitem => templeitem.Id, templeitem => districts.Where(x => x.DistrictId == templeitem.did).ToList());
            ViewBag.clist = temple.ToDictionary(templeitem => templeitem.Id, templeitem => cities.Where(x => x.CityId == templeitem.cid).ToList());

            foreach (var templeitem in temple)
            {
                const int maxLines = 1;
                const int maxWordsPerLine = 20;

                var lines = templeitem.detail.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var truncatedLines = lines.Take(maxLines);

                foreach (var line in truncatedLines)
                {
                    var words = line.Split(' ');
                    var truncatedWords = words.Take(maxWordsPerLine);
                    var truncatedLine = string.Join(" ", truncatedWords);

                    if (words.Length > maxWordsPerLine)
                    {
                        truncatedLine += " ...";
                    }

                    templeitem.detail = truncatedLine;
                    break;
                }

            }

            return View(temple);
        }

        public ActionResult TempleDetail(int id)
        {
            var temple = db.TempleListings.Single(x => x.Id == id);

            ViewBag.slist = db.States.Where(t => t.StateId == temple.sid).Select(t => t.StateName).FirstOrDefault();
            ViewBag.dlist = db.Districts.Where(t => t.DistrictId == temple.did).Select(t => t.DistrictName).FirstOrDefault();
            ViewBag.clist = db.Cities.Where(t => t.CityId == temple.cid).Select(t => t.CityName).FirstOrDefault();

            var article = db.Blog_Table.OrderBy(x => Guid.NewGuid()).ToList();

            foreach (var articleitem in article)
            {
                const int maxLines = 1;
                const int maxWordsPerLine = 10;

                var lines = articleitem.blogDetail.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var truncatedLines = lines.Take(maxLines);

                foreach (var line in truncatedLines)
                {
                    var words = line.Split(' ');
                    var truncatedWords = words.Take(maxWordsPerLine);
                    var truncatedLine = string.Join(" ", truncatedWords);

                    if (words.Length > maxWordsPerLine)
                    {
                        truncatedLine += " ...";
                    }

                    articleitem.blogDetail = truncatedLine;
                    break;
                }
            }

            ViewBag.allarticles = article;

            return View(temple);
        }

        public ActionResult Article()
        {
            var article = db.Blog_Table.OrderBy(x => Guid.NewGuid()).ToList();

            foreach (var articleitem in article)
            {
                const int maxLines = 1;
                const int maxWordsPerLine = 15;

                var lines = articleitem.blogDetail.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var truncatedLines = lines.Take(maxLines);

                foreach (var line in truncatedLines)
                {
                    var words = line.Split(' ');
                    var truncatedWords = words.Take(maxWordsPerLine);
                    var truncatedLine = string.Join(" ", truncatedWords);

                    if (words.Length > maxWordsPerLine)
                    {
                        truncatedLine += " ...";
                    }

                    articleitem.blogDetail = truncatedLine;
                    break;
                }
            }
            return View(article);
        }

        public ActionResult ArticleDetail(int id)
        {
            var a = db.Blog_Table.Single(x => x.Id == id);

            var article = db.Blog_Table.Where(x => x.Id != id).OrderBy(x => Guid.NewGuid()).ToList();

            foreach (var articleitem in article)
            {
                const int maxLines = 1;
                const int maxWordsPerLine = 10;

                var lines = articleitem.blogDetail.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                var truncatedLines = lines.Take(maxLines);

                foreach (var line in truncatedLines)
                {
                    var words = line.Split(' ');
                    var truncatedWords = words.Take(maxWordsPerLine);
                    var truncatedLine = string.Join(" ", truncatedWords);

                    if (words.Length > maxWordsPerLine)
                    {
                        truncatedLine += " ...";
                    }

                    articleitem.blogDetail = truncatedLine;
                    break;
                }
            }

            ViewBag.allarticles = article;

            return View(a);
        }

        public ActionResult Contact()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Contact(ContactEnquire c)
        {
            if (!ModelState.IsValid)
            {
                return Json(new { success = false });
            }
            c.rts = DateTime.Now;
            db.ContactEnquires.Add(c);
            db.SaveChanges();
            return Json(new { success = true });
        }
    }
}