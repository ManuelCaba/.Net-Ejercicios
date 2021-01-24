using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.System;
using Windows.UI.Core;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Animation;
using Windows.UI.Xaml.Navigation;

// La plantilla de elemento Página en blanco está documentada en https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0xc0a

namespace Animaciones4
{
    /// <summary>
    /// Página vacía que se puede usar de forma independiente o a la que se puede navegar dentro de un objeto Frame.
    /// </summary>
    public sealed partial class MainPage : Page
    {

        public MainPage()
        {
            this.InitializeComponent();
            sbEstrellasGrandes.Begin();
            sbEstrellasGrandes2.Begin();
            sbEstrellasPequenas.Begin();
            sbEstrellasPequenas2.Begin();
            sbEstrellasPequenas3.Begin();
        }
        
        private void HandleKeyDown(CoreWindow sender, KeyEventArgs args)
        {
            if (args.VirtualKey == VirtualKey.Right)
                Canvas.SetLeft(imgNave, Canvas.GetLeft(imgNave) + 10);
            else if (args.VirtualKey == VirtualKey.Left)
                Canvas.SetLeft(imgNave, Canvas.GetLeft(imgNave) - 10);
            else if (args.VirtualKey == VirtualKey.Up)
                Canvas.SetTop(imgNave, Canvas.GetTop(imgNave) - 10);
            else if (args.VirtualKey == VirtualKey.Down)
                Canvas.SetTop(imgNave, Canvas.GetTop(imgNave) + 10);
        }


        protected override void OnNavigatedFrom(NavigationEventArgs e)
        {
            base.OnNavigatedFrom(e);

            Window.Current.CoreWindow.KeyDown -= HandleKeyDown;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);

            Window.Current.CoreWindow.KeyDown += HandleKeyDown;
        }

    }
}
