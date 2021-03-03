using ExamenUWPDAL.Listados;
using ExamenUWPEntidades;
using System.Collections.Generic;

namespace ExamenUWPBL.Listados
{
    public class clsListadoAulasBL
    {
        private static clsListadoAulasDAL clsListadoAulasDAL = new clsListadoAulasDAL();

        /// <summary>
        /// Devuelve un listado completo de aulas
        /// </summary>
        /// <returns></returns>
        public List<clsAula> listadoAulasBL()
        {
            return clsListadoAulasDAL.listadoAulasDAL();
        }
    }
}
