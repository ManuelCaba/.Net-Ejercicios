using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _11_CRUDPersonasDepartamentos_DAL.Manejadoras;
using _11_CRUDPersonasDepartamentos_Entidades;
using _11_CRUDPersonasDepartamentos_BL.Listados;
using _11_CRUDPersonasDepartamentos_BL.Excepciones;

namespace _11_CRUDPersonasDepartamentos_BL.Manejadoras
{
    public class clsManejadoraDepartamentosBL
    {
        /// <summary>
        /// Elimina un departamento en la base de datos a partir de su ID
        /// </summary>
        /// <param name="IDDepartamento"></param>
        /// <returns></returns>
        public int eliminarDepartamentoBL(int IDDepartamento)
        {
            clsManejadoraDepartamentosDAL clsManejadoraDepartamentos = new clsManejadoraDepartamentosDAL();
            clsListadoPersonasBL clsListadoPersonas = new clsListadoPersonasBL();

            int filasAfectadas = 0;

            if(clsListadoPersonas.listadoPersonasPorIDDepmartamentoDAL(IDDepartamento).Count() == 0)
            {
                filasAfectadas = clsManejadoraDepartamentos.eliminarDepartamentoDAL(IDDepartamento);
            }
            else
            {
                throw new DepartmentContainsPeopleException("This department contains people");
            }
                
            return filasAfectadas;
        }

        /// <summary>
        /// Edita un departamento en la base de datos a partir de un objeto departamento
        /// </summary>
        /// <param name="departamento"></param>
        /// <returns></returns>
        public int editarDepartamentoBL(clsDepartamento departamento)
        {
            clsManejadoraDepartamentosDAL clsManejadoraDepartamentos = new clsManejadoraDepartamentosDAL();

            return clsManejadoraDepartamentos.editarDepartamentoDAL(departamento);
        }

        /// <summary>
        /// Crear un departamento en la base de datos a partir de un objeto departamento
        /// </summary>
        /// <param name="departamento"></param>
        /// <returns></returns>
        public int crearDepartamentoBL(clsDepartamento departamento)
        {
        clsManejadoraDepartamentosDAL clsManejadoraDepartamentos = new clsManejadoraDepartamentosDAL();

        return clsManejadoraDepartamentos.crearDepartamentoDAL(departamento);
    }
    }
}

