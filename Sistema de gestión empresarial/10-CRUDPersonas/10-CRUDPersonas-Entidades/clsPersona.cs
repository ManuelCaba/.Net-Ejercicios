using System;
using System.ComponentModel;
using System.Globalization;

namespace _10_CRUDPersonas_Entidades
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

        public clsPersona()
        {
            ID = 0;
            Nombre = "";
            Apellidos = "";
            FechaNacimiento = DateTime.Parse("14-12-2000");
            Foto = null;
            Direccion = "";
            Telefono = "";
            IDDepartamento = 0;
        }
        #endregion
    }
}
