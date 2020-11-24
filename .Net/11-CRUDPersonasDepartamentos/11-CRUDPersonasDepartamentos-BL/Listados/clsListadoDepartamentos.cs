using _11_CRUDPersonasDepartamentos_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _11_CRUDPersonasDepartamentos_BL.Listados
{
    public class clsListadoDepartamentos
    {
        public String nombreDepartamentoPorPersona(int IDPersona)
        {
            _11_CRUDPersonasDepartamentos_DAL.Listados.clsListadoDepartamentos clsListadoDepartamentos = new _11_CRUDPersonasDepartamentos_DAL.Listados.clsListadoDepartamentos();

            return clsListadoDepartamentos.nombreDepartamentoPorPersona(IDPersona);
        }

        public List<clsDepartamento> listadoDepartamentos()
        {
            _11_CRUDPersonasDepartamentos_DAL.Listados.clsListadoDepartamentos clsListadoDepartamentos = new _11_CRUDPersonasDepartamentos_DAL.Listados.clsListadoDepartamentos();

            return clsListadoDepartamentos.listadoDepartamentos();
        }
    }
}
