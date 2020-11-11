using System;
using System.ComponentModel;
using System.Globalization;

namespace _11_BindingCommand_01.Models
{
    public class clsPersona
    {
        #region Propiedades

        public String Nombre { get; set; }

        public String Apellidos { get; set; }

        public DateTime FechaNacimiento { get; set; }

        public String Telefono { get; set; }

        public String Direccion { get; set; }
        #endregion

        #region Constructores
        public clsPersona(String nombre, String apellidos, DateTime fechaNacimiento, String telefono, String direccion)
        {
            Nombre = nombre;
            Apellidos = apellidos;
            FechaNacimiento = fechaNacimiento;
            Telefono = telefono;
            Direccion = direccion;
        }

        public clsPersona()
        {
            Nombre = "Manuel";
            Apellidos = "Caballero Leiva";
            FechaNacimiento = DateTime.Parse("14-12-2000");
            Telefono = "648778933";
            Direccion = "Calle Tintilla, 6";
        }
        #endregion
    }
}
