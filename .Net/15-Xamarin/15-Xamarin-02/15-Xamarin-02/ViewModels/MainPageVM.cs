using _15_Xamarin_02.Models;
using _15_Xamarin_02.Utilidades;
using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;

namespace _15_Xamarin_02.ViewModels {
    public class MainPageVM {

        #region Atributos
        private clsPersona personaInmutable;
        private clsPersona personaCambiable;
        #endregion

        #region Propiedades
        public clsPersona PersonaCambiable 
        { 
            get
            {
                return personaCambiable;
            } 
            set 
            {
                this.personaCambiable = value;                    
            } 
        }
        public DelegateCommand ComandoSaludar { get; }
        #endregion

        #region Constructores
        public MainPageVM()
        {
            personaInmutable = new clsPersona();
            PersonaCambiable = new clsPersona(personaInmutable);
            ComandoSaludar = new DelegateCommand(ComandoSaludar_ExecutedAsync, ComandoSaludar_CanExecute);
        }
        #endregion

        #region Métodos

        private bool ComandoSaludar_CanExecute()
        {
            bool canExecute = true;

            if(personaInmutable.Equals(personaCambiable))
            {
                canExecute = false;
            }

            return canExecute;
        }

        private async void ComandoSaludar_ExecutedAsync()
        {
            await Application.Current.MainPage.DisplayAlert("Datos", "Nombre: " + personaCambiable.Nombre + "\n" +
                                                                     "Apellidos: " + personaCambiable.Apellidos + "\n" +
                                                                     "Direccion: " + personaCambiable.Direccion + "\n" +
                                                                     "Telefono: " + personaCambiable.Telefono + "\n" +
                                                                     "Fecha Nacimiento: " + personaCambiable.FechaNacimiento + "\n" +
                                                                     "ID Departamento: " + personaCambiable.IDDepartamento + "\n", "Ok");
            personaInmutable = new clsPersona(personaCambiable);
        }

        public void ActualizarSaludar(object sender, TextChangedEventArgs e)
        {
            ComandoSaludar.RaiseCanExecuteChanged();
        }

        #endregion


    }
}
