using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using CRUDPersonasXamarin_DAL.Conexion;
using CRUDPersonasXamarin_Entidades;
using Newtonsoft.Json;

namespace CRUDPersonasXamarin_DAL.Manejadoras
{
    public class clsManejadoraPersonasDAL
    {
        /// <summary>
        /// Elimina una persona en la base de datos a partir de su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public async Task<HttpStatusCode> eliminarPersonaDALAsync(int IDPersona)
        {
            HttpClient mihttpClient = new HttpClient();

            string miCadenaUrl = clsUriBase.UriBase();

            Uri miUri = new Uri($"{miCadenaUrl}Personas/{IDPersona}");

            //Usaremos el Status de la respuesta para comprobar si ha borrado

            HttpResponseMessage miRespuesta = new HttpResponseMessage();

            try
            {
                miRespuesta = await mihttpClient.DeleteAsync(miUri);
            } 
            catch (Exception ex)
            {
                throw ex;
            }

            return miRespuesta.StatusCode;
        }

        /// <summary>
        /// Edita una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public async Task<HttpStatusCode> editarPersonaDALAsync(clsPersona persona)
        {
            HttpClient mihttpClient = new HttpClient();

            String datos;

            HttpContent contenido;

            String miCadenaUrl = clsUriBase.UriBase();

            Uri miUri = new Uri($"{miCadenaUrl}Personas");

            //Usaremos el Status de la respuesta para comprobar si ha actualizado

            HttpResponseMessage miRespuesta = new HttpResponseMessage();

            try
            {
                datos = JsonConvert.SerializeObject(persona);

                contenido = new StringContent(datos, System.Text.Encoding.UTF8, "application/json");

                miRespuesta = await mihttpClient.PutAsync(miUri, contenido);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return miRespuesta.StatusCode;
        }

        /// <summary>
        /// Crear una persona en la base de datos a partir de un objeto persona
        /// </summary>
        /// <param name="persona"></param>
        /// <returns></returns>
        public async Task<HttpStatusCode> crearPersonaDALAsync(clsPersona persona)
        {
            HttpClient mihttpClient = new HttpClient();

            String datos;

            HttpContent contenido;

            String miCadenaUrl = clsUriBase.UriBase();

            Uri miUri = new Uri($"{miCadenaUrl}Personas");

            //Usaremos el Status de la respuesta para comprobar si ha actualizado

            HttpResponseMessage miRespuesta = new HttpResponseMessage();

            try
            {
                datos = JsonConvert.SerializeObject(persona);

                contenido = new StringContent(datos, System.Text.Encoding.UTF8, "application/json");

                miRespuesta = await mihttpClient.PostAsync(miUri, contenido);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return miRespuesta.StatusCode;
        }
    }
}
