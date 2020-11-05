using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace _08_DatosControlador.Models
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(String nombre)
        {
            ViewBag.nombre = nombre;
            return View("Saludo");
        }

        public ActionResult Saludo(String nombre)
        {
            ViewBag.nombre = nombre;

            return View();
        }

        public ActionResult Editar()
        {
            clsPersona persona = new clsPersona();

            persona.ID = 5;
            persona.nombre = "Manuel";
            persona.apellidos = "Caballero";

            return View(persona);
        }

        [HttpPost]
        public ActionResult Editar(clsPersona persona)
        {
            return View("PersonaModificada", persona);
        }


    }
}