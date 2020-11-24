using _10_CRUDPersonas_BL.Listados;
using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _10_CRUDPersonas_UI.Models
{
    public class clsListadosPersonasConNombreDepartamento
    {
        /// <summary>
        /// Devuelve un listado completo de personas con nombre de departamento
        /// </summary>
        /// <returns></returns>
        public static List<clsPersonaConNombreDepartamento> listadoCompletoPersonas()
        {
            clsListadoDepartamentos clsListadoDepartamentos = new clsListadoDepartamentos();

            List<clsPersona> listaPersonas = new clsListadoPersonas().listadoPersonas();
            List<clsPersonaConNombreDepartamento> listadosPersonasConNombreDepartamento = new List<clsPersonaConNombreDepartamento>();
            clsPersonaConNombreDepartamento personaConNombreDepartamento;

            foreach (clsPersona persona in listaPersonas)
            {
                personaConNombreDepartamento = new clsPersonaConNombreDepartamento(persona, clsListadoDepartamentos.nombreDepartamentoPorID(persona.IDDepartamento));

                listadosPersonasConNombreDepartamento.Add(personaConNombreDepartamento);
            }

            return listadosPersonasConNombreDepartamento;
        }
    }
}