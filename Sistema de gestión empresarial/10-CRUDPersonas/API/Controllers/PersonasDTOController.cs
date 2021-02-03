using _10_CRUDPersonas_API.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace API.Controllers
{
    public class PersonasDTOController : ApiController
    {
        // GET: api/PersonasDTO
        public IEnumerable<clsPersonaDTO> Get()
        {
            return clsListadosPersonasDTO.listadoCompletoPersonas();
        }

        // GET: api/PersonasDTO/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/PersonasDTO
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/PersonasDTO/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/PersonasDTO/5
        public void Delete(int id)
        {
        }
    }
}
