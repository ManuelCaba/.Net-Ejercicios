﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDPersonasXamarin_Entidades
{
    public class clsDepartamento
    {
        #region Propiedades
        public int ID { get; set; }

        public String Nombre { get; set; }
        #endregion

        #region Constructores
        public clsDepartamento(int ID, String nombre)
        {
            this.ID = ID;
            Nombre = nombre;
        }

        public clsDepartamento(clsDepartamento departamento)
        {
            this.ID = departamento.ID;
            Nombre = departamento.Nombre;
        }

        public clsDepartamento()
        {
            ID = 0;
            Nombre = "";
        }
        #endregion
    }
}
