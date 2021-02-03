﻿using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_API.DTO
{
    public class clsPersonaDTO : clsPersona
    {
        #region Propiedades
        public String NombreDepartamento { get; set; }
        #endregion

        #region Constructores
        public clsPersonaDTO(int ID, String nombre, String apellidos, DateTime fechaNacimiento, Byte[] foto, String direccion, String telefono, int IDDepartamento, String nombreDepartamento) :
            base(ID, nombre, apellidos, fechaNacimiento, foto, direccion, telefono, IDDepartamento)
        {
            this.NombreDepartamento = nombreDepartamento;
        }

        public clsPersonaDTO(clsPersona p, String nombreDepartamento) :
            base(p.ID, p.Nombre, p.Apellidos, p.FechaNacimiento, p.Foto, p.Direccion, p.Telefono, p.IDDepartamento)
        {
            this.NombreDepartamento = nombreDepartamento;
        }

        public clsPersonaDTO() : base()
        {
            NombreDepartamento = "";
        }
        #endregion
    }
}
