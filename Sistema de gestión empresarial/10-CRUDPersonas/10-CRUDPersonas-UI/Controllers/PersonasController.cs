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
        //Listar
        public ActionResult Listado()
        {
            return View(clsListadosPersonasConNombreDepartamento.listadoCompletoPersonas());
        }

        //Eliminar
        public ActionResult Delete(int id)
        {
            clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();

            clsPersona persona = clsListadoPersonasBL.obtenerPersonaPorIDBL(id);

            return View(persona);
        }

        [HttpPost, ActionName("Delete")]
        public ActionResult Delete_Post(int id)
        {
            clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();

            clsManejadoraPersonasBL.eliminarPersonaBL(id);

            return View("Listado", clsListadosPersonasConNombreDepartamento.listadoCompletoPersonas());

        }

        //Editar
        public ActionResult Edit(int id)
        {
            clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();

            clsPersona persona = clsListadoPersonasBL.obtenerPersonaPorIDBL(id);

            return View(new clsPersonaConListadoDepartamentos(persona));
        }

        [HttpPost]
        public ActionResult Edit(clsPersonaConListadoDepartamentos personaConListadoDepartamentos)
        {
            clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();

            clsPersona persona = new clsPersona();
            persona.ID = personaConListadoDepartamentos.ID;
            persona.Nombre = personaConListadoDepartamentos.Nombre;
            persona.Apellidos = personaConListadoDepartamentos.Apellidos;
            persona.FechaNacimiento = personaConListadoDepartamentos.FechaNacimiento;
            persona.Foto = personaConListadoDepartamentos.Foto;
            persona.Direccion = personaConListadoDepartamentos.Direccion;
            persona.Telefono = personaConListadoDepartamentos.Telefono;
            persona.IDDepartamento = personaConListadoDepartamentos.IDDepartamento;

            clsManejadoraPersonasBL.editarPersonaBL(persona);

            return View("Listado", clsListadosPersonasConNombreDepartamento.listadoCompletoPersonas());
        }

        //Editar
        public ActionResult Create()
        {
            return View(new clsPersonaConListadoDepartamentos());
        }

        [HttpPost]
        public ActionResult Create(clsPersonaConListadoDepartamentos personaConListadoDepartamentos)
        {
            clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();

            clsPersona persona = new clsPersona();
            persona.ID = personaConListadoDepartamentos.ID;
            persona.Nombre = personaConListadoDepartamentos.Nombre;
            persona.Apellidos = personaConListadoDepartamentos.Apellidos;
            persona.FechaNacimiento = personaConListadoDepartamentos.FechaNacimiento;
            persona.Foto = personaConListadoDepartamentos.Foto;
            persona.Direccion = personaConListadoDepartamentos.Direccion;
            persona.Telefono = personaConListadoDepartamentos.Telefono;
            persona.IDDepartamento = personaConListadoDepartamentos.IDDepartamento;

            clsManejadoraPersonasBL.crearPersonaBL(persona);

            return View("Listado", clsListadosPersonasConNombreDepartamento.listadoCompletoPersonas());
        }
    }
}