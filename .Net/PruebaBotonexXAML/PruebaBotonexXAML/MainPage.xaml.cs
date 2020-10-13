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

namespace PruebaBotonexXAML
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
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btn2_Click(object sender, RoutedEventArgs e)
        {
            //Buscamos si existe el botón 3
            if (stkBotones.FindName("btn3") == null)
            {
                Button btn3 = new Button();

                btn3.Name = "btn3";
                btn3.Content = "Boton 3";
                btn3.HorizontalAlignment = HorizontalAlignment.Center;
                btn3.VerticalAlignment = VerticalAlignment.Center;
                btn3.Background = new SolidColorBrush(Windows.UI.Colors.Blue);
                btn3.Width = 200;
                btn3.Height = 70;
                btn3.FontSize = 20;
                btn3.FontFamily = new FontFamily("Verdana");
                btn3.FontWeight = Windows.UI.Text.FontWeights.Bold;
                btn3.BorderBrush = new SolidColorBrush(Windows.UI.Colors.Yellow);
                btn3.Margin = new Thickness(30);
                btn3.Click += btn3_Click;


                stkBotones.Children.Add(btn3);
            }
        }

        private void btn3_Click(object sender, RoutedEventArgs e)
        {
            if(btn1.IsEnabled)
            {
                btn1.IsEnabled = false;
                btn1.Opacity = 0;
            }
            else
            {
                btn1.IsEnabled = true;
                btn1.Opacity = 1;
            }

        }



    }
}
