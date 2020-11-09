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
            clsPersonaDepartamentos personaDepartamentos = new clsPersonaDepartamentos();

            personaDepartamentos.Persona.ID = 1;
            personaDepartamentos.Persona.Nombre = "Manuel";
            personaDepartamentos.Persona.Apellidos = "Caballero";
            personaDepartamentos.Persona.FechaNacimiento = DateTime.Parse("14-12-2000");
            personaDepartamentos.Persona.Departamento = new clsDepartamento(4, "Recursos Humanos");

            return View(personaDepartamentos);
        }

        [HttpPost]
        public ActionResult Editar(clsPersonaDepartamentos personaDepartamentos)
        {
            clsPersona persona = personaDepartamentos.Persona;

            List<clsDepartamento> listadoDepartamentos = clsListados.listadoDepartamentos();

            foreach(clsDepartamento departamento in listadoDepartamentos)
            {
               if(personaDepartamentos.Persona.Departamento.ID == departamento.ID)
                {
                    persona.Departamento.Nombre = departamento.Nombre;
                }
            }

            if(ModelState.IsValid)
            {
                return View("PersonaModificada", persona);
            }
            else
            {
                return View(persona);
            }
        }


    }
}