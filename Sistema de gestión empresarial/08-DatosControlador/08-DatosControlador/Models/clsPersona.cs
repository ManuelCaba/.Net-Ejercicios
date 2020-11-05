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
        public String nombre { get; set; }

        [MaxLength(40, ErrorMessage = "No permite mas de 40 caracteres"), Required(ErrorMessage = "Campo Obligatorio")]
        public String apellidos { get; set; }

        [Display(Name = "Fecha de Nacimiento")]
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        public DateTime fechaNacimiento { get; set; }

        [MaxLength(40, ErrorMessage = "No permite mas de 200 caracteres")]
        public String direccion { get; set; }

        [DataType(DataType.PhoneNumber)]
        public String telefono { get; set; }
        #endregion

        #region Constructores
        public clsPersona(int ID, String nombre, String apellidos, DateTime fechaNacimiento, String direccion, String telefono)
        {
            this.ID = ID;
            this.nombre = nombre;
            this.apellidos = apellidos;
            this.fechaNacimiento = fechaNacimiento;
            this.direccion = direccion;
            this.telefono = telefono;
        }

        public clsPersona()
        {
            this.ID = 0;
            this.nombre = "";
            this.apellidos = "";
            this.fechaNacimiento = new DateTime();
            this.direccion = "";
            this.telefono = "";
        }
        #endregion
    }
}
