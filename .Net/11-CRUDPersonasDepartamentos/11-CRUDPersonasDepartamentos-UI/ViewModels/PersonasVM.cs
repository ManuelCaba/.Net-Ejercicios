using _10_CRUDPersonas_BL.Listados;
using _11_CRUDPersonasDepartamentos_BL.Listados;
using _11_CRUDPersonasDepartamentos_Entidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _11_CRUDPersonasDepartamentos_UI.ViewModels
{
    public class PersonasVM : Utilidades.clsVMBase
    {
        #region Atributos
        private clsPersona personaSeleccionada;
        #endregion

        #region Propiedades
        public ObservableCollection<clsPersona> ListadoPersonas { get; }
        public ObservableCollection<clsDepartamento> ListadoDepartamentos { get; set; }
        public clsPersona PersonaSeleccionada
        {
            get
            {
                return personaSeleccionada;
            }

            set
            {
                personaSeleccionada = value;
                NotifyPropertyChanged("PersonaSeleccionada");
            }
        }
        #endregion

        #region Constructores
        public PersonasVM()
        {

            clsListadoPersonas listadoPersonas = new clsListadoPersonas();
            clsListadoDepartamentos listadoDepartamentos = new clsListadoDepartamentos();
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            ListadoPersonas = new ObservableCollection<clsPersona>(listadoPersonas.listadoPersonas());
            ListadoDepartamentos = new ObservableCollection<clsDepartamento>(listadoDepartamentos.listadoDepartamentos());
        }
        #endregion
    }
}
