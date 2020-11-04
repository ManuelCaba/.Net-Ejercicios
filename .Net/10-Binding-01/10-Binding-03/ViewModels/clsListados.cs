using _10_Binding_03.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _10_Binding_03.Models
{
    class clsListados
    {
        /*
         * Función que devuelve un ObservableCollection de clsPersona ya inicializados
         */
        public ObservableCollection<clsPersona> listadoPersonas()
        {
            ObservableCollection<clsPersona> listadoPersonas = new ObservableCollection<clsPersona>();

            listadoPersonas.Add(new clsPersona("Manuel", "Caballero", DateTime.Parse("14-12-2000"), "648778933", "Calle Tintilla, 6"));
            listadoPersonas.Add(new clsPersona("Juan", "Quiros", DateTime.Parse("11-7-2000"), "634191623", "Calle Sagrado Corazon de Jesus, 11"));
            listadoPersonas.Add(new clsPersona("Isidro", "Sanchez", DateTime.Parse("02-02-2000"), "632193729", "Calle Polvoraa, 4, 6A"));
            listadoPersonas.Add(new clsPersona("Manuel", "Franco", DateTime.Parse("25-04-1996"), "674291832", "Avenida Poeta Manuel Benitez Carrasco, 10, 5B"));

            return listadoPersonas;
        }
    }
}
