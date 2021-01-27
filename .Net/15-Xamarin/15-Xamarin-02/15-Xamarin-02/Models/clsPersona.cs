using System;
using System.ComponentModel;
using System.Globalization;

namespace _15_Xamarin_02.Models
{
    public class clsPersona
    {
        #region Propiedades
        public int ID { get; set; }

        public String Nombre { get; set; }

        public String Apellidos { get; set; }

        public DateTime FechaNacimiento { get; set; }

        public Byte[] Foto { get; set; }

        public String Direccion { get; set; }

        public String Telefono { get; set; }

        public int IDDepartamento { get; set; }

        
        #endregion

        #region Constructores
        public clsPersona(int ID, String nombre, String apellidos, DateTime fechaNacimiento, Byte[] foto, String direccion, String telefono, int IDDepartamento)
        {
            this.ID = ID;
            Nombre = nombre;
            Apellidos = apellidos;
            FechaNacimiento = fechaNacimiento;
            Foto = foto;
            Direccion = direccion;
            Telefono = telefono;
            this.IDDepartamento = IDDepartamento;
        }

        public clsPersona(clsPersona persona)
        {
            this.ID = persona.ID;
            Nombre = persona.Nombre;
            Apellidos = persona.Apellidos;
            FechaNacimiento = persona.FechaNacimiento;
            Foto = persona.Foto;
            Direccion = persona.Direccion;
            Telefono = persona.Telefono;
            this.IDDepartamento = persona.IDDepartamento;
        }

        public clsPersona()
        {
            ID = 1;
            Nombre = "Manuel";
            Apellidos = "Caballero Leiva";
            FechaNacimiento = new DateTime(2000,12,14);
            Foto = new Byte[0];
            Direccion = "Calle Tintilla, 6";
            Telefono = "648778933";
            IDDepartamento = 1;
        }
        #endregion

        #region Métodos Sobreescritos
        public override bool Equals(object obj)
        {
            bool rest = false;

            if(this == obj)
            {
                rest = true;
            }
            else if(obj != null && typeof(clsPersona).IsInstanceOfType(obj))
            {
                clsPersona persona = (clsPersona) obj;

                if(this.ID == persona.ID)
            }

            return rest;
        }
        #endregion
    }
}
