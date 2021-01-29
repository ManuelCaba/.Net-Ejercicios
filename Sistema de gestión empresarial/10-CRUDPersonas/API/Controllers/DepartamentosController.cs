using System;
using _10_CRUDPersonas_Entidades;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace API.Controllers
{
    public class DepartamentosController : ApiController
    {
        // GET: api/Departamentos
        public IEnumerable<clsDepartamento> Get()
        {
            List<clsDepartamento> listadoDepartamentos;

            try
            {
                listadoDepartamentos = new _10_CRUDPersonas_BL.Listados.clsListadoDepartamentosBL().listadoDepartamentosBL();
            }
            catch (Exception e)
            {
                throw new HttpResponseException(HttpStatusCode.ServiceUnavailable);
            }

            if (listadoDepartamentos == null || listadoDepartamentos.Count == 0)
            {
                throw new HttpResponseException(HttpStatusCode.NoContent);
            }

            return listadoDepartamentos;
        }

        // GET: api/Departamentos/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Departamentos
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Departamentos/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Departamentos/5
        public void Delete(int id)
        {
        }
    }
}
