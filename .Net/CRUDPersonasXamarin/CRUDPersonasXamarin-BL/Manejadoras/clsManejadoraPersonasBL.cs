using CRUDPersonasXamarin_DAL.Manejadoras;
using CRUDPersonasXamarin_Entidades;
using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace CRUDPersonasXamarin_BL.Manejadoras
{
    public class clsManejadoraPersonasBL
    {
        private static clsManejadoraPersonasDAL clsManejadoraPersonasDAL = new clsManejadoraPersonasDAL();

        /// <summary>
        /// Elimina una persona en la base de datos a partir de su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public async Task<HttpStatusCode> eliminarPersonaBLAsync(int IDPersona)
        {
            return await clsManejadoraPersonasDAL.eliminarPersonaDALAsync(IDPersona);
        }

        /// <summary>
        /// Edita una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public async Task<HttpStatusCode> editarPersonaBLAsync(clsPersona persona)
        {
            return await clsManejadoraPersonasDAL.editarPersonaDALAsync(persona);
        }

        /// <summary>
        /// Crear una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public async Task<HttpStatusCode> crearPersonaBLAsync(clsPersona persona)
        {
            return await clsManejadoraPersonasDAL.crearPersonaDALAsync(persona);
        }
    }
}
