using ExamenAJAXDAL.Listados;
using ExamenAJAXEntidades;
using System.Collections.Generic;

namespace ExamenAJAXBL.Listados
{
    public class clsListadoMisionesBL
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
    }
}
