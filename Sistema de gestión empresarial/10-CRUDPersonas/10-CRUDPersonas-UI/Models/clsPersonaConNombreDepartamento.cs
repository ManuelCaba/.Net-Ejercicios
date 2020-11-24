using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_UI.Models
{
    public class clsPersonaConNombreDepartamento : clsPersona
    {
        #region Propiedades
        public String NombreDepartamento { get; set; }
        #endregion

        #region Constructores
        public clsPersonaConNombreDepartamento(int ID, String nombre, String apellidos, DateTime fechaNacimiento, Byte[] foto, String direccion, String telefono, int IDDepartamento, String nombreDepartamento) :
            base(ID, nombre, apellidos, fechaNacimiento, foto, direccion, telefono, IDDepartamento)
        {
            this.NombreDepartamento = nombreDepartamento;
        }

        public clsPersonaConNombreDepartamento(clsPersona p, String nombreDepartamento) :
            base(p.ID, p.Nombre, p.Apellidos, p.FechaNacimiento, p.Foto, p.Direccion, p.Telefono, p.IDDepartamento)
        {
            this.NombreDepartamento = nombreDepartamento;
        }

        public clsPersonaConNombreDepartamento() : base()
        {
            NombreDepartamento = "";
        }
        #endregion
    }
}
