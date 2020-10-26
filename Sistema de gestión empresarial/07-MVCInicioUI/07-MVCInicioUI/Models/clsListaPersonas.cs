using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _07_MVCInicioUI.Models
{
    public class clsListaPersonas
    {
        #region Atributos
        public List<clsPersona> listaPersonas { get; set; }
        #endregion

        #region Constructores
        public clsListaPersonas()
        {
            clsPersona persona1 = new clsPersona(1, "Manuel", "Caballero Leiva", 20);
            clsPersona persona2 = new clsPersona(2, "Francisco", "Aviles", 21);
            clsPersona persona3 = new clsPersona(3, "Cristina", "Caballero Leiva", 22);
            clsPersona persona4 = new clsPersona(4, "Juan", "Quiros Rodriguez", 20);
            clsPersona persona5 = new clsPersona(5, "Manuel", "Perez Franco", 26);

            listaPersonas = new List<clsPersona>();

            this.listaPersonas.Add(persona1);
            this.listaPersonas.Add(persona2);
            this.listaPersonas.Add(persona3);
            this.listaPersonas.Add(persona4);
            this.listaPersonas.Add(persona5);
        }
        #endregion
    }
}