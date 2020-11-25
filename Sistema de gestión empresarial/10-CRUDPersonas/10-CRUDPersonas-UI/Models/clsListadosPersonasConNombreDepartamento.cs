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
            clsListadoDepartamentosBL clsListadoDepartamentos = new clsListadoDepartamentosBL();

            List<clsPersona> listaPersonas = new clsListadoPersonasBL().listadoPersonasBL();
            List<clsPersonaConNombreDepartamento> listadosPersonasConNombreDepartamento = new List<clsPersonaConNombreDepartamento>();
            clsPersonaConNombreDepartamento personaConNombreDepartamento;

            foreach (clsPersona persona in listaPersonas)
            {
                personaConNombreDepartamento = new clsPersonaConNombreDepartamento(persona, clsListadoDepartamentos.nombreDepartamentoPorIDBL(persona.IDDepartamento));

                listadosPersonasConNombreDepartamento.Add(personaConNombreDepartamento);
            }

            return listadosPersonasConNombreDepartamento;
        }
    }
}