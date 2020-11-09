using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace _08_DatosControlador.Models
{
    public class clsPersona
    {
        #region Propiedades

        [HiddenInput(DisplayValue = false)]
        public int ID { get; set; }

        [Required(ErrorMessage = "Campo Obligatorio")]
        public String Nombre { get; set; }

        [MaxLength(40, ErrorMessage = "No permite mas de 40 caracteres"), Required(ErrorMessage = "Campo Obligatorio")]
        public String Apellidos { get; set; }

        [Display(Name = "Fecha de Nacimiento")]
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        public DateTime FechaNacimiento { get; set; }

        [MaxLength(40, ErrorMessage = "No permite mas de 200 caracteres")]
        public String Direccion { get; set; }

        [DataType(DataType.PhoneNumber)]
        public String Telefono { get; set; }

        public clsDepartamento Departamento { get; set; }
        #endregion

        #region Constructores
        public clsPersona(int ID, String nombre, String apellidos, DateTime fechaNacimiento, String direccion, String telefono, clsDepartamento departamento)
        {
            this.ID = ID;
            this.Nombre = nombre;
            this.Apellidos = apellidos;
            this.FechaNacimiento = fechaNacimiento;
            this.Direccion = direccion;
            this.Telefono = telefono;
            this.Departamento = departamento;
        }

        public clsPersona()
        {
            this.ID = 0;
            this.Nombre = "";
            this.Apellidos = "";
            this.FechaNacimiento = new DateTime();
            this.Direccion = "";
            this.Telefono = "";
            this.Departamento = null;
        }
        #endregion
    }
}
