using CRUDPersonasXamarin_DAL.Conexion;
using CRUDPersonasXamarin_Entidades;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace CRUDPersonasXamarin_DAL.Listados
{
    public class clsListadoPersonasDAL
    {
        /// <summary>
        /// Devuelve un listado completo de personas
        /// </summary>
        /// <returns></returns>
        public async Task<List<clsPersona>> listadoPersonasDALAsync()
        {
            //Pido la cadena de la Uri al método estático

            String miCadenaUrl = clsUriBase.UriBase();

            Uri miUri = new Uri($"{miCadenaUrl}Personas");

            List<clsPersona> listadoPersonas = new List<clsPersona>();

            HttpClient mihttpClient;

            HttpResponseMessage miCodigoRespuesta;

            String textoJsonRespuesta;

            //Instanciamos el cliente Http

            mihttpClient = new HttpClient();

            try
            {
                miCodigoRespuesta = await mihttpClient.GetAsync(miUri);

                if (miCodigoRespuesta.IsSuccessStatusCode)
                {
                    textoJsonRespuesta = await mihttpClient.GetStringAsync(miUri);

                    mihttpClient.Dispose();

                    //JsonConvert necesita using Newtonsoft.Json;

                    //Es el paquete Nuget de Newtonsoft

                    listadoPersonas =
                    JsonConvert.DeserializeObject<List<clsPersona>>(textoJsonRespuesta);

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return listadoPersonas;

        }


        /// <summary>
        /// Devuelve una persona por su ID
        /// </summary>
        /// <param name="IDPersona"></param>
        /// <returns></returns>
        public async Task<clsPersona> obtenerPersonaPorIDDALAsync(int IDPersona)
        {
            //Pido la cadena de la Uri al método estático

            String miCadenaUrl = clsUriBase.UriBase();

            Uri miUri = new Uri($"{miCadenaUrl}Personas/{IDPersona}");

            clsPersona persona = new clsPersona();

            HttpClient mihttpClient;

            HttpResponseMessage miCodigoRespuesta;

            String textoJsonRespuesta;

            //Instanciamos el cliente Http

            mihttpClient = new HttpClient();

            try
            {
                miCodigoRespuesta = await mihttpClient.GetAsync(miUri);

                if (miCodigoRespuesta.IsSuccessStatusCode)
                {
                    textoJsonRespuesta = await mihttpClient.GetStringAsync(miUri);

                    mihttpClient.Dispose();

                    //JsonConvert necesita using Newtonsoft.Json;

                    //Es el paquete Nuget de Newtonsoft

                    persona = JsonConvert.DeserializeObject<clsPersona>(textoJsonRespuesta);

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return persona;

        }
    }
}
