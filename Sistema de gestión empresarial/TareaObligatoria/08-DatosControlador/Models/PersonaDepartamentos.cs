using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _08_DatosControlador.Models
{
    public class PersonaDepartamentos
    {
        #region Propiedades
        public clsPersona Persona { get; set; }
        public List<clsDepartamento> Departamentos { get; set; }
        #endregion

        #region Constructores
        public PersonaDepartamentos(clsPersona persona)
        {
            this.Persona = persona;
            this.Departamentos = clsListados.listadoDepartamentos();
        }

        public PersonaDepartamentos()
        {
            this.Persona = new clsPersona();
            this.Departamentos = clsListados.listadoDepartamentos();
        }
        #endregion
    }
}