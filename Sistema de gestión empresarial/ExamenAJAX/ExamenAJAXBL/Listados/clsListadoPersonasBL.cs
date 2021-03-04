using ExamenAJAXDAL.Listados;
using System.Collections.Generic;

namespace ExamenAJAXBL.Listados
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

        /// <summary>
        /// Devuelve un listado de personas según un IDDepartamento
        /// </summary>
        /// <param name="IDDepartamento"></param>
        /// <returns></returns>
        public List<clsPersona> listadoPersonasPorIDDepmartamentoDAL(int IDDepartamento)
        {
            return clsListadoPersonas.listadoPersonasPorIDDepmartamentoDAL(IDDepartamento);
        }
    }
}
