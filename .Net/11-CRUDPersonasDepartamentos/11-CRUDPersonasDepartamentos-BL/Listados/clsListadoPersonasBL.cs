using _11_CRUDPersonasDepartamentos_DAL.Listados;
using _11_CRUDPersonasDepartamentos_Entidades;
using System.Collections.Generic;

namespace _11_CRUDPersonasDepartamentos_BL.Listados
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
