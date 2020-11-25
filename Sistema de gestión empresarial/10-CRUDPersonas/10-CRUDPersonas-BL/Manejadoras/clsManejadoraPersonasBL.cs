using System;
using System.Collections.Generic;
using _10_CRUDPersonas_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using _10_CRUDPersonas_DAL.Manejadoras;

namespace _10_CRUDPersonas_BL.Manejadoras
{
    public class clsManejadoraPersonasBL
    {
        public int eliminarPersonaBL(int IDPersona)
        {
            clsManejadoraPersonasDAL clsManejadoraPersonas = new clsManejadoraPersonasDAL();

            return clsManejadoraPersonas.eliminarPersonaDAL(IDPersona);
        }
    }
}
