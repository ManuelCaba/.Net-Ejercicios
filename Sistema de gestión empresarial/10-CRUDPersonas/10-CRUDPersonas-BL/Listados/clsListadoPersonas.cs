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
    public class clsListadoPersonas
    {
        public List<clsPersona> listadoPersonas()
        {
            _10_CRUDPersonas_DAL.Listados.clsListadoPersonas clsListadoPersonas = new _10_CRUDPersonas_DAL.Listados.clsListadoPersonas();

            return clsListadoPersonas.listadoPersonas();
        }
    }
}
