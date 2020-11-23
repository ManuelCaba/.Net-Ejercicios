using _11_CRUDPersonasDepartamentos_UI.Views;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0xc0a

namespace _11_CRUDPersonasDepartamentos_UI
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


        private void nvwItemInvoked(NavigationView sender, NavigationViewItemInvokedEventArgs args)
        {
            //First determine if the setting is selected
            if (args.IsSettingsInvoked)
            {
                contentFrame.Navigate(typeof(MainPage));
            }
            else
            {
                //Selected content
                switch (args.InvokedItem)
                {
                    case "Personas":
                        contentFrame.Navigate(typeof(Personas));
                        break;
                    case "Departamentos":
                        contentFrame.Navigate(typeof(Departamentos));
                        break;
                }
            }

        }
    }
}
