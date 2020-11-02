using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Devices.Geolocation;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Maps;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=234238

namespace Solarizr
{
    /// <summary>
    /// Una página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class AppointmentsPage : Page
    {
        public AppointmentsPage()
        {
            this.InitializeComponent();
            Mapa.Loaded += Map_Loaded;
        }

        /// <summary>
        /// Método para inicializar la ubicación del mapa
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private async void Map_Loaded(object sender, RoutedEventArgs e)
        {

            var center =
                new Geopoint(new BasicGeoposition()
                {
                    Latitude = 36.626543,
                    Longitude = -6.371709

                });

            await Mapa.TrySetSceneAsync(MapScene.CreateFromLocationAndRadius(center, 3000));
        }

        /// <summary>
        /// Método que te envía a la página DetailsPage
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void goToDetailsPage(Object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(DetailsPage));
        }

    }

}  
