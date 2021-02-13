using CRUDPersonasXamarin_DAL.Conexion;
using CRUDPersonasXamarin_Entidades;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace CRUDPersonasXamarin_DAL.Listados
{
    public class clsListadoDepartamentosDAL
    {
        /// <summary>
        /// Devuelve un listado completo de departamentos
        /// </summary>
        /// <returns></returns>
        public async Task<List<clsDepartamento>> listadoDepartamentosDALAsync()
        {
            //Pido la cadena de la Uri al método estático

            String miCadenaUrl = clsUriBase.UriBase();

            Uri miUri = new Uri($"{miCadenaUrl}Departamentos");

            List<clsDepartamento> listadoDepartamentos = new List<clsDepartamento>();

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

                    listadoDepartamentos = JsonConvert.DeserializeObject<List<clsDepartamento>>(textoJsonRespuesta);

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return listadoDepartamentos;

        }
    }
}
