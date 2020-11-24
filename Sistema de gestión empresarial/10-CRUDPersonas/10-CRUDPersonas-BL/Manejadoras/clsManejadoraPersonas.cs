using System;
using System.Collections.Generic;
using _10_CRUDPersonas_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace _10_CRUDPersonas_BL.Manejadoras
{
    public class clsManejadoraPersonas
    {
        public int eliminarPersona(int IDPersona)
        {
            _10_CRUDPersonas_DAL.Manejadoras.clsManejadoraPersonas clsManejadoraPersonas = new _10_CRUDPersonas_DAL.Manejadoras.clsManejadoraPersonas();

            return clsManejadoraPersonas.eliminarPersona(IDPersona);
        }
    }
}
