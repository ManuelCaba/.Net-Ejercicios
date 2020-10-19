using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace _02_HolaMundoASP.NET_UI.Controllers
{
    public class ProductosController : Controller
    {
        // GET: Productos
        public ActionResult ListadoProductos()
        {
            return View();
        }
    }
}