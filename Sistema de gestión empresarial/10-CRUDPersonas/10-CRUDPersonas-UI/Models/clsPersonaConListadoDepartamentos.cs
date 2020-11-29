using _10_CRUDPersonas_BL.Listados;
using _10_CRUDPersonas_Entidades;
using System.ComponentModel.DataAnnotations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _10_CRUDPersonas_UI.Models
{
    public class clsPersonaConListadoDepartamentos : clsPersona
    {
        #region Atributos
        private List<clsDepartamento> listadoDepartamentos;
        #endregion

        #region Propiedades
        public List<clsDepartamento> ListadoDepartamentos { get{ return listadoDepartamentos; } }
        #endregion

        #region Constructores
        public clsPersonaConListadoDepartamentos(clsPersona persona)
        {
            clsListadoDepartamentosBL clsListadoDepartamentosBL = new clsListadoDepartamentosBL();

            this.ID = persona.ID;
            this.Nombre = persona.Nombre;
            this.Apellidos = persona.Apellidos;
            this.FechaNacimiento = persona.FechaNacimiento;
            this.Foto = persona.Foto;
            this.Direccion = persona.Direccion;
            this.Telefono = persona.Telefono;
            this.IDDepartamento = persona.IDDepartamento;
            this.listadoDepartamentos = clsListadoDepartamentosBL.listadoDepartamentosBL();
        }

        public clsPersonaConListadoDepartamentos() : base()
        {
            clsListadoDepartamentosBL clsListadoDepartamentosBL = new clsListadoDepartamentosBL();
            this.listadoDepartamentos = clsListadoDepartamentosBL.listadoDepartamentosBL();
        }
        #endregion

        #region Métodos
        #endregion
    }
}