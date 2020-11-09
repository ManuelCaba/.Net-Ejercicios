using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _08_DatosControlador.Models
{
    public class clsPersonaDepartamentos
    {
        #region Propiedades
        public clsPersona Persona { get; set; }
        public List<clsDepartamento> Departamentos { get; set; }
        #endregion

        #region Constructores
        public clsPersonaDepartamentos(clsPersona persona)
        {
            this.Persona = persona;
            this.Departamentos = clsListados.listadoDepartamentos();
        }

        public clsPersonaDepartamentos()
        {
            this.Persona = new clsPersona();
            this.Departamentos = clsListados.listadoDepartamentos();
        }
        #endregion
    }
}