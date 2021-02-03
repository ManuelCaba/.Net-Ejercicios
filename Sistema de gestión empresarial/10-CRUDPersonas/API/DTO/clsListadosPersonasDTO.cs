using _10_CRUDPersonas_BL.Listados;
using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _10_CRUDPersonas_API.DTO
{
    public class clsListadosPersonasDTO
    {
        /// <summary>
        /// Devuelve un listado completo de personas con nombre de departamento
        /// </summary>
        /// <returns></returns>
        public static List<clsPersonaDTO> listadoCompletoPersonas()
        {
            clsListadoDepartamentosBL clsListadoDepartamentos = new clsListadoDepartamentosBL();

            List<clsPersona> listaPersonas = new clsListadoPersonasBL().listadoPersonasBL();
            List<clsPersonaDTO> listadosPersonasConNombreDepartamento = new List<clsPersonaDTO>();
            clsPersonaDTO personaConNombreDepartamento;

            foreach (clsPersona persona in listaPersonas)
            {
                personaConNombreDepartamento = new clsPersonaDTO(persona, clsListadoDepartamentos.nombreDepartamentoPorIDBL(persona.IDDepartamento));

                listadosPersonasConNombreDepartamento.Add(personaConNombreDepartamento);
            }

            return listadosPersonasConNombreDepartamento;
        }
    }
}