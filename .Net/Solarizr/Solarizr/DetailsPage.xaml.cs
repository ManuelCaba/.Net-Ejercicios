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

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=234238

namespace Solarizr
{
    /// <summary>
    /// Una página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class DetailsPage : Page
    {
        public DetailsPage()
        {
            this.InitializeComponent();
        }

        /// <summary>
        /// Método que te envía a la página AppointmentsPage
        /// </summary>

        public void goToAppointmentsPage(Object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(AppointmentsPage));
        }

        /// <summary>
        /// Abre un cuadro de diálogo para confirmar si quiere guardar los
        /// cambios, en caso positivo se guardará
        /// </summary>
        public async void guardarFormulario(object sender, RoutedEventArgs e)
        {
            ContentDialog deleteFileDialog = new ContentDialog
            {
                Title = "Guardar los cambios",
                Content = "Deseas guardar los cambios?",
                PrimaryButtonText = "Guardar",
                CloseButtonText = "Cancelar"
            };

            ContentDialogResult result = await deleteFileDialog.ShowAsync();
        }
    }
}
