using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Web;

namespace _08_DatosControlador.Models
{
    public class clsListados
    {
        /// <summary>
        /// Método que devuelve un listado de departamentos
        /// </summary>
        /// <returns></returns>
        public static List<clsDepartamento> listadoDepartamentos()
        {
            List<clsDepartamento> listadoDepartamentos = new List<clsDepartamento>();

            listadoDepartamentos.Add(new clsDepartamento(1, "Marketing y Ventas"));
            listadoDepartamentos.Add(new clsDepartamento(2, "Contabilidad y Finanzas"));
            listadoDepartamentos.Add(new clsDepartamento(3, "Cadena de Suministro"));
            listadoDepartamentos.Add(new clsDepartamento(4, "Recursos Humanos"));

            return listadoDepartamentos;
        }

    }
}