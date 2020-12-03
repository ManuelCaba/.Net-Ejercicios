using System;
using System.Collections.Generic;
using CRUDMandalorian_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using CRUDMandalorian_Entidades;

namespace CRUDMandalorian_DAL.Manejadoras
{
    public class clsManejadoraMisionesBL
    {
        private clsManejadoraMisionesDAL clsManejadoraMisiones = new clsManejadoraMisionesDAL();

        /// <summary>
        /// Modifica el precio de una misión
        /// </summary>
        /// <param name="IDMision"></param>
        /// <param name="precio"></param>
        /// <returns></returns>
        public int modificarPrecioBL(int IDMision, int precio)
        {
            return clsManejadoraMisiones.modificarPrecioDAL(IDMision, precio);
        }
    }
}
