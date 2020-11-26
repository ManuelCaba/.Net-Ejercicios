using System;
using System.Collections.Generic;
using _10_CRUDPersonas_DAL.Conexion;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using _10_CRUDPersonas_DAL.Manejadoras;
using _10_CRUDPersonas_Entidades;

namespace _10_CRUDPersonas_BL.Manejadoras
{
    public class clsManejadoraPersonasBL
    {
        /// <summary>
        /// Elimina una persona en la base de datos a partir de su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public int eliminarPersonaBL(int IDPersona)
        {
            clsManejadoraPersonasDAL clsManejadoraPersonas = new clsManejadoraPersonasDAL();

            return clsManejadoraPersonas.eliminarPersonaDAL(IDPersona);
        }

        /// <summary>
        /// Edita una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public int editarPersonaBL(clsPersona persona)
        {
            clsManejadoraPersonasDAL clsManejadoraPersonas = new clsManejadoraPersonasDAL();

            return clsManejadoraPersonas.editarPersonaDAL(persona);
        }

        /// <summary>
        /// Crear una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public int crearPersonaBL(clsPersona persona)
        {
            clsManejadoraPersonasDAL clsManejadoraPersonas = new clsManejadoraPersonasDAL();

            return clsManejadoraPersonas.crearPersonaDAL(persona);
        }
    }
}
