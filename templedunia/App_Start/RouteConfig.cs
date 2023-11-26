using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace templedunia
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
              name: "turl",
              url: "TempleDetail/{id}",
              defaults: new { controller = "Home", action = "TempleDetail" }
          );

            routes.MapRoute(
              name: "aurl",
              url: "ArticleDetail/{id}",
              defaults: new { controller = "Home", action = "ArticleDetail" }
          );

            routes.MapRoute(
    name: "Admin",
    url: "Admin/{action}/{id}",
    defaults: new { controller = "Admin", action = "Index", id = UrlParameter.Optional }
);


            routes.MapRoute(
                name: "Default",
                url: "{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}

