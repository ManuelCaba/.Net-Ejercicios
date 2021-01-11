using System.Collections.Generic;
using ProyectoCore_BL.Listados;
using ProyectoCore_DAL.Listados;
using ProyectoCore_Entidades;

namespace ProyectoCore_BL.Listados
{
    public class clsListadoPersonasBL
    {
        private static clsListadoPersonasDAL clsListadoPersonas = new clsListadoPersonasDAL();

        /// <summary>
        /// Devuelve un listado completo de personas
        /// </summary>
        /// <returns></returns>
        public List<clsPersona> listadoPersonasBL()
        {
            return clsListadoPersonas.listadoPersonasDAL();
        }

        /// <summary>
        /// Devuelve una persona por su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public clsPersona obtenerPersonaPorIDBL(int IDPersona)
        {
            return clsListadoPersonas.obtenerPersonaPorIDDAL(IDPersona);
        }
    }
}
