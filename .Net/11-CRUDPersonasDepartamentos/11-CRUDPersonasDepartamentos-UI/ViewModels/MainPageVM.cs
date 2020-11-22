using _10_CRUDPersonas_BL.Listados;
using _11_CRUDPersonasDepartamentos_Entidades;
using _11_CRUDPersonasDepartamentos_UI.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _11_CRUDPersonasDepartamentos_UI.ViewModels
{
    public class MainPageVM : Utilidades.clsVMBase
    {
        #region Atributos
        private clsPersona personaSeleccionada;
        #endregion

        #region Propiedades
        public ObservableCollection<clsPersonaNombreDepartamento> ListadoPersonas { get; }
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
        public MainPageVM()
        {

            clsListadoPersonas listadoPersonas = new clsListadoPersonas();
            //Rellenamos el listado de personas porque hace falta nada mas entrar en la página
            ListadoPersonas = listadoPersonas.listadoPersonas();
        }
        #endregion

        #region INotifyPropertyChanged

        private void NotifyPropertyChanged(String property)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(property));
            }
        }

        #endregion
    }
}
