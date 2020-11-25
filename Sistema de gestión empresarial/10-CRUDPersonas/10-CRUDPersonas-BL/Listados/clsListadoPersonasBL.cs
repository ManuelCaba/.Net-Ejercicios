using _10_CRUDPersonas_DAL.Conexion;
using _10_CRUDPersonas_Entidades;
using _10_CRUDPersonas_DAL.Listados;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_BL.Listados
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
