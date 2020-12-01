using _10_CRUDPersonas_BL.Listados;
using _10_CRUDPersonas_BL.Manejadoras;
using _10_CRUDPersonas_Entidades;
using _10_CRUDPersonas_UI.Models;
using System;
using System.Collections.Generic;
using System.IO;
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
        public ActionResult Edit(clsPersonaConListadoDepartamentos personaConListadoDepartamentos, HttpPostedFileBase upload)
        {
            if(ModelState.IsValid)
            {
                clsManejadoraPersonasBL clsManejadoraPersonasBL = new clsManejadoraPersonasBL();
                clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();

                clsPersona persona = clsListadoPersonasBL.obtenerPersonaPorIDBL(personaConListadoDepartamentos.ID);

                persona.Nombre = personaConListadoDepartamentos.Nombre;
                persona.Apellidos = personaConListadoDepartamentos.Apellidos;
                persona.FechaNacimiento = personaConListadoDepartamentos.FechaNacimiento;
                persona.Foto = personaConListadoDepartamentos.Foto == null ? persona.Foto : personaConListadoDepartamentos.Foto ;
                persona.Direccion = personaConListadoDepartamentos.Direccion;
                persona.Telefono = personaConListadoDepartamentos.Telefono;
                persona.IDDepartamento = personaConListadoDepartamentos.IDDepartamento;

                if (upload != null && upload.ContentLength > 0)
                {
                    using (var reader = new System.IO.BinaryReader(upload.InputStream))
                    {
                        persona.Foto = reader.ReadBytes(upload.ContentLength);
                    };
                }

                clsManejadoraPersonasBL.editarPersonaBL(persona);

                
                return View(new clsPersonaConListadoDepartamentos(persona));
            }
            else
            {
                return View(personaConListadoDepartamentos);
            }

        }

        //Editar
        public ActionResult Create()
        {
            return View(new clsPersonaConListadoDepartamentos());
        }

        [HttpPost]
        public ActionResult Create(clsPersonaConListadoDepartamentos personaConListadoDepartamentos, HttpPostedFileBase upload)
        {
            if (ModelState.IsValid)
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

                if (upload != null && upload.ContentLength > 0)
                {
                    using (var reader = new System.IO.BinaryReader(upload.InputStream))
                    {
                        persona.Foto = reader.ReadBytes(upload.ContentLength);
                    };
                }

                clsManejadoraPersonasBL.crearPersonaBL(persona);

                return View("Edit", new clsPersonaConListadoDepartamentos(persona));
            }
            else
            {
                return View(personaConListadoDepartamentos);
            }
        }

        //Details
        public ActionResult Details(int id)
        {
            clsListadoPersonasBL clsListadoPersonasBL = new clsListadoPersonasBL();
            clsListadoDepartamentosBL clsListadoDepartamentosBL = new clsListadoDepartamentosBL();

            clsPersona persona = clsListadoPersonasBL.obtenerPersonaPorIDBL(id);

            return View(new clsPersonaConNombreDepartamento(persona, clsListadoDepartamentosBL.nombreDepartamentoPorIDBL(persona.IDDepartamento)));
        }

    }
}