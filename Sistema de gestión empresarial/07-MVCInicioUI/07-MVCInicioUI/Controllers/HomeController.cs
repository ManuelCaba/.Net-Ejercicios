using _07_MVCInicioUI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace _07_MVCInicioUI.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            //Devolvemos un mensaje de saludo dependiendo del horario con ViewData
            if(DateTime.Now.Hour >= 6 && DateTime.Now.Hour < 12)
            {
                ViewData["Saludo"] = "Buenos dias";
            }
            else if(DateTime.Now.Hour >= 12 && DateTime.Now.Hour < 20)
            {
                ViewData["Saludo"] = "Buenas tardes";
            }
            else
            {
                ViewData["Saludo"] = "Buenas noches";
            }

            //Devolvemos la fecha actual en formato largo con ViewBag
            ViewBag.Fecha = DateTime.Now.ToLongDateString();

            //Creación del objeto clsPersona
            clsPersona persona = new clsPersona(1, "Manuel", "Caballero Leiva", 20);

            //Inicialización de los atributos del objeto creado
            /*persona.ID = 1;
            persona.nombre = "Manuel";
            persona.apellidos = "Caballero Leiva";
            persona.edad = 20;*/

            return View(persona);
        }

        public ActionResult ListadoPersonas()
        {
            return View(new clsListaPersonas());
        }
    }
}