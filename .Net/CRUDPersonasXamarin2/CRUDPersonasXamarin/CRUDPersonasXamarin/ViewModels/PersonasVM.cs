using CRUDPersonasXamarin_Entidades;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace CRUDPersonasXamarin_UI.ViewModels {
    public class PersonasVM {
        #region Atributos
        private ObservableCollection<clsPersona> listaPersonas;
        #endregion

        #region Propiedades
        public ObservableCollection<clsPersona> ListaPersonas 
        { 
            get 
            { 
                return listaPersonas; 
            } 
            set 
            { 
                listaPersonas = value; 
            } 
        }
        #endregion
    }
}
