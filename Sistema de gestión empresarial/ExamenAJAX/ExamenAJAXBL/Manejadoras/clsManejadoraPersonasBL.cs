using ExamenAJAXDAL.Manejadoras;

namespace ExamenAJAXBL.Manejadoras
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
