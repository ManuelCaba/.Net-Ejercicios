using _01_HolaMundoWF_Entities;
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
            listaPersonas.Add(new clsPersona(1, "Manuel", "Caballero Leiva", 20));
            listaPersonas.Add(new clsPersona(2, "Francisco", "Aviles", 21));
            listaPersonas.Add(new clsPersona(3, "Cristina", "Caballero Leiva", 22));
            listaPersonas.Add(new clsPersona(4, "Juan", "Quiros Rodriguez", 20));
            listaPersonas.Add(new clsPersona(5, "Manuel", "Perez Franco", 26));
        }
        #endregion
    }
}