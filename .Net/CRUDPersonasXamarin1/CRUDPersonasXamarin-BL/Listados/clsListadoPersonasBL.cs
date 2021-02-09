using CRUDPersonasXamarin_DAL.Listados;
using CRUDPersonasXamarin_Entidades;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CRUDPersonasXamarin.Listados
{
    public class clsListadoPersonasBL
    {
        private static clsListadoPersonasDAL clsListadoPersonas = new clsListadoPersonasDAL();

        /// <summary>
        /// Devuelve un listado completo de personas
        /// </summary>
        /// <returns></returns>
        public async Task<List<clsPersona>> listadoPersonasBLAsync()
        {
            return await clsListadoPersonas.listadoPersonasDALAsync();
        }

        /// <summary>
        /// Devuelve una persona por su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public async Task<clsPersona> obtenerPersonaPorIDBLAsync(int IDPersona)
        {
            return await clsListadoPersonas.obtenerPersonaPorIDDALAsync(IDPersona);
        }
    }
}
