using _10_CRUDPersonas_BL.Listados;
using _10_CRUDPersonas_BL.Manejadoras;
using _10_CRUDPersonas_Entidades;
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

        public ActionResult Delete(int id)
        {
            clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();

            clsPersona persona = clsListadoPersonasBL.obtenerPersonaPorIDBL(id);

            return View(persona);
        }

        [HttpPost]
        [ActionName("Delete")]
        public ActionResult Delete_Post(int id)
        {
            clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();

            clsManejadoraPersonasBL.eliminarPersonaBL(id);

            return View("Listado", clsListadosPersonasConNombreDepartamento.listadoCompletoPersonas());

        }
    }
}