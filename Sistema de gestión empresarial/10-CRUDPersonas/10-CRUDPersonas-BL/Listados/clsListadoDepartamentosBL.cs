using _10_CRUDPersonas_DAL.Listados;
using _10_CRUDPersonas_Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_CRUDPersonas_BL.Listados
{
    public class clsListadoDepartamentosBL
    {
        public String nombreDepartamentoPorIDBL(int IDDepartamento)
        {
            clsListadoDepartamentosDAL clsListadoDepartamentos = new clsListadoDepartamentosDAL();

            return clsListadoDepartamentos.nombreDepartamentoPorIDDAL(IDDepartamento);
        }

        public List<clsDepartamento> listadoDepartamentosBL()
        {
            clsListadoDepartamentosDAL clsListadoDepartamentos = new clsListadoDepartamentosDAL();

            return clsListadoDepartamentos.listadoDepartamentosDAL();
        }
    }
}
