using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_BL.Listados
{
    public class clsListadoDepartamentos
    {
        public String nombreDepartamentoPorID(int IDDepartamento)
        {
            _10_CRUDPersonas_DAL.Listados.clsListadoDepartamentos clsListadoDepartamentos = new _10_CRUDPersonas_DAL.Listados.clsListadoDepartamentos();

            return clsListadoDepartamentos.nombreDepartamentoPorID(IDDepartamento);
        }

        public List<clsDepartamento> listadoDepartamentos()
        {
            _10_CRUDPersonas_DAL.Listados.clsListadoDepartamentos clsListadoDepartamentos = new _10_CRUDPersonas_DAL.Listados.clsListadoDepartamentos();

            return clsListadoDepartamentos.listadoDepartamentos();
        }
    }
}
