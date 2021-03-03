using ExamenUWPDAL.Listados;
using ExamenUWPEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamenUWPBL.Listados
{
    public class clsListadoTemperaturasBL
    {
        private static clsListadoTemperaturasDAL clsListadoTemperaturasDAL = new clsListadoTemperaturasDAL();

        /// <summary>
        /// Devuelve una temperatura según una fecha y un IDAula
        /// </summary>
        /// <param name="IDAula"></param>
        /// <param name="fecha"></param>
        /// <returns></returns>
        public clsTemperatura temperaturasPorAulaYFecha(int IDAula, DateTime fecha)
        {
            return clsListadoTemperaturasDAL.temperaturasPorAulaYFecha(IDAula, fecha);
        }
    }
}
