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
                throw new HttpResponseException(HttpStatusCode.NoContent);
            }

            return listadoPersonas;
            
        }

        // GET: api/Personas/5
        public clsPersona Get(int id)
        {
            clsPersona persona;

            try
            {
                persona = new _10_CRUDPersonas_BL.Listados.clsListadoPersonasBL().obtenerPersonaPorIDBL(id);
            }
            catch (Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if (persona == null)
            {
                throw new HttpResponseException(HttpStatusCode.NoContent);
            }

            return persona;
        }

        // POST: api/Personas
        public void Post([FromBody]clsPersona value)
        {
            int filasAfectadas;

            try
            {
                filasAfectadas = new _10_CRUDPersonas_BL.Manejadoras.clsManejadoraPersonasBL().crearPersonaBL(value);
            } 
            catch(Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }
            
            if(filasAfectadas == 0)
            {
                throw new HttpResponseException(HttpStatusCode.BadRequest);
            }
            else
            {
                throw new HttpResponseException(HttpStatusCode.Created);
            }
        }

        // PUT: api/Personas/5
        public void Put(int id, [FromBody]clsPersona persona)
        {
            int filasAfectadas;

            persona.ID = id;

            try
            {
                filasAfectadas = new _10_CRUDPersonas_BL.Manejadoras.clsManejadoraPersonasBL().editarPersonaBL(persona);
            }
            catch (Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if (filasAfectadas == 0)
            {
                throw new HttpResponseException(HttpStatusCode.BadRequest);
            }
            else
            {
                throw new HttpResponseException(HttpStatusCode.OK);
            }
        }

        // DELETE: api/Personas/5
        public void Delete(int id)
        {
            int filasAfectadas;

            try
            {
                filasAfectadas = new _10_CRUDPersonas_BL.Manejadoras.clsManejadoraPersonasBL().eliminarPersonaBL(id);
            }
            catch (Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if (filasAfectadas == 0)
            {
                throw new HttpResponseException(HttpStatusCode.BadRequest);
            }
            else
            {
                throw new HttpResponseException(HttpStatusCode.NoContent);
            }
            
        }
    }
}
