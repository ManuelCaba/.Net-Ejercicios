﻿using _03_HolaMundoUWP_Clases;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0xc0a

namespace _03_HolaMundoUWP
{
    /// <summary>
    /// Página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class MainPage : Page
    {
        public MainPage()
        {
            this.InitializeComponent();
        }

        private void TextBlock_SelectionChanged_1(object sender, RoutedEventArgs e)
        {

        }

        private async void btnSaludar_Click(object sender, RoutedEventArgs e)
        {
            //Instanciamos objeto de tipo persona
            ClsPersona persona = new ClsPersona();

            String nombre = txbNombre.Text;

            if (!String.IsNullOrEmpty(nombre))
            {
                persona.Nombre = nombre;
                txkErrorNombre.Text = "";
                var dialogo = new MessageDialog($"Hola {persona.Nombre}");
                await dialogo.ShowAsync();

            }
            else
            {
                txkErrorNombre.Text = "Debe escribir un nombre";
            }
        }

    
    }
}
