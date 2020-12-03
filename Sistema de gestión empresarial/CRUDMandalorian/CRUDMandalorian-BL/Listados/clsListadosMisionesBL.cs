using CRUDMandalorian_Entidades;
using CRUDMandalorian_DAL.Conexion;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDMandalorian_DAL.Listados
{
    public class clsListadosMisionesBL
    {
        private clsListadosMisionesDAL clsListadosMisiones = new clsListadosMisionesDAL();

        /// <summary>
        /// Devuelve un listado completo de las misiones no terminadas
        /// </summary>
        /// <returns></returns>
        public List<clsMision> listadoMisionesPendientesBL()
        {
            return clsListadosMisiones.listadoMisionesPendientesDAL();
        }

        /// <summary>
        /// Devuelve una mision por su ID
        /// </summary>
        /// <param name="IDMision"></param>
        /// <returns></returns>
        public clsMision obtenerMisionPorIDDBL(int IDMision)
        {
            return clsListadosMisiones.obtenerMisionPorIDDAL(IDMision);
        }
    }
}
