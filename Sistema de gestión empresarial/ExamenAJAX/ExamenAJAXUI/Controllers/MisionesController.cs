using ExamenAJAXBL.Listados;
using ExamenAJAXBL.Manejadoras;
using ExamenAJAXEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace ExamenAJAXUI.Controllers
{
    public class MisionesController : ApiController
    {
        // GET: api/Misiones
        public IEnumerable<clsMision> Get()
        {
            List<clsMision> listadoMisiones;

            try
            {
                listadoMisiones = new clsListadoMisionesBL().listadoMisionesPendientesBL();
            }
            catch (Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if (listadoMisiones == null || listadoMisiones.Count == 0)
            {
                throw new HttpResponseException(HttpStatusCode.NoContent);
            }

            return listadoMisiones;
        }

        // GET: api/Misiones/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Misiones
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Misiones/5
        public void Put(int id, [FromBody]clsMision mision)
        {
            int filasAfectadas;

            mision.id = id;

            try
            {
                filasAfectadas = new clsManejadoraMisionesBL().modificarPrecioBL(id, mision.creditos);
            }
            catch (Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if (filasAfectadas == 0)
            {
                throw new HttpResponseException(HttpStatusCode.BadRequest);
            }
        }

        // DELETE: api/Misiones/5
        public void Delete(int id)
        {
        }
    }
}
