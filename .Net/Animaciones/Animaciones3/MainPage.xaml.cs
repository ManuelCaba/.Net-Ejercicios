using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Threading.Tasks;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.System.Threading;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0xc0a

namespace Animaciones3
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

        private async void btnLanzamiento_Click(object sender, RoutedEventArgs e)
        {
            btnLanzamiento.IsEnabled = false;

            storyBoard.Begin();

            for (int i = 10; i >= 0; i--)
            {
                countdown.Text = i.ToString();

                //cuentaAtras.Begin();

                await Task.Delay(1000);
            }

            countdown.Text = "";  
        }

        private void DoubleAnimation_Completed(object sender, object e)
        {
            btnLanzamiento.IsEnabled = true;
            Canvas.SetTop(nave, 363);
        }
    }
}
