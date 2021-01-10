using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace API.Controllers
{
    public class PersonasController : ApiController
    {
        // GET: api/Personas
        public IEnumerable<clsPersona> Get()
        {
            List<clsPersona> listadoPersonas;

            try
            {
                listadoPersonas = new _10_CRUDPersonas_BL.Listados.clsListadoPersonasBL().listadoPersonasBL();
            } 
            catch(Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if(listadoPersonas == null || listadoPersonas.Count == 0)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            return listadoPersonas;
            
        }

        // GET: api/Personas/5
        public clsPersona Get(int id)
        {
            return new _10_CRUDPersonas_BL.Listados.clsListadoPersonasBL().obtenerPersonaPorIDBL(id);
        }

        // POST: api/Personas
        public void Post([FromBody]clsPersona value)
        {
            new _10_CRUDPersonas_BL.Manejadoras.clsManejadoraPersonasBL().crearPersonaBL(value);
        }

        // PUT: api/Personas/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Personas/5
        public void Delete(int id)
        {
            new _10_CRUDPersonas_BL.Manejadoras.clsManejadoraPersonasBL().eliminarPersonaBL(id);
        }
    }
}
