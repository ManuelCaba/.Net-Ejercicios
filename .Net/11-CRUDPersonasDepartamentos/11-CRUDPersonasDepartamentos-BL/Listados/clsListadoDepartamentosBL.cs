using _11_CRUDPersonasDepartamentos_DAL.Listados;
using _11_CRUDPersonasDepartamentos_Entidades;
using System;
using System.Collections.Generic;

namespace _11_CRUDPersonasDepartamentos_BL.Listados
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
