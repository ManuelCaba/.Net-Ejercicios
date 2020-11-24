using _10_CRUDPersonas_BL.Listados;
using _10_CRUDPersonas_UI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace _10_CRUDPersonas_UI.Controllers
{
    public class PersonasController : Controller
    {
        // GET: Personas
        public ActionResult Listado()
        {
            return View(clsListadosPersonasConNombreDepartamento.listadoCompletoPersonas());
        }
    }
}