using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace templedunia.Models
{
    public partial class TempleListing
    {
        public virtual List<State> State { get; set; }
        public virtual List<District> District { get; set; }
        public virtual List<City> City { get; set; }
    }
}