using CRUDPersonasXamarin_DAL.Listados;
using CRUDPersonasXamarin_Entidades;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CRUDPersonasXamarin_BL.Listados
{
    public class clsListadoDepartamentosBL
    {
        private static clsListadoDepartamentosDAL clsListadoDepartamentos = new clsListadoDepartamentosDAL();

        /// <summary>
        /// Devuelve un listado completo de departamentos
        /// </summary>
        /// <returns></returns>
        public async Task<List<clsDepartamento>> listadoDepartamentosBL()
        {
            return await clsListadoDepartamentos.listadoDepartamentosDALAsync();
        }
    }
}
