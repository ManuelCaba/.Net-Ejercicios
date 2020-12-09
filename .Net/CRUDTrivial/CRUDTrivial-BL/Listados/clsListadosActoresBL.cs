using CRUDTrivial_DAL.Listados;
using CRUDTrivial_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDTrivial_BL.Listados
{
    public class clsListadosActoresBL
    {
        private static clsListadosActoresDAL listadosActores = new clsListadosActoresDAL();
        /// <summary>
        /// Devuelve un listado completo de actores
        /// </summary>
        /// <returns></returns>
        public List<clsActor> listadoActoresBL()
        {
            return listadosActores.listadoActoresDAL();
        }
    }
}
