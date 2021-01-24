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

namespace Animaciones_Juego
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

        private void HandleKeyDown(Windows.UI.Core.CoreWindow sender, Windows.UI.Core.KeyEventArgs args)
        {
            if (args.VirtualKey == Windows.System.VirtualKey.Right)
                Canvas.SetLeft(Nave, Canvas.GetLeft(Nave) + 10);
            else if (args.VirtualKey == Windows.System.VirtualKey.Left)
                Canvas.SetLeft(Nave, Canvas.GetLeft(Nave) - 10);
            else if (args.VirtualKey == Windows.System.VirtualKey.Up)
                Canvas.SetTop(Nave, Canvas.GetTop(Nave) - 10);
            else if (args.VirtualKey == Windows.System.VirtualKey.Down)
                Canvas.SetTop(Nave, Canvas.GetTop(Nave) + 10);
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

        private void Canvas_SizeChanged(object sender, SizeChangedEventArgs e)

        {

            //----------------< Canvas_SizeChanged() >----------------





            Canvas canvas = sender as Canvas;

            SizeChangedEventArgs canvas_Changed_Args = e;



            //< check >

            //*if size=0 then initial

            if (canvas_Changed_Args.PreviousSize.Width == 0) return;

            //</ check >



            //< init >

            double old_Height = canvas_Changed_Args.PreviousSize.Height;

            double new_Height = canvas_Changed_Args.NewSize.Height;

            double old_Width = canvas_Changed_Args.PreviousSize.Width;

            double new_Width = canvas_Changed_Args.NewSize.Width;



            double scale_Width = new_Width / old_Width;

            double scale_Height = new_Height / old_Height;

            //</ init >





            //----< adapt all children >----

            foreach (FrameworkElement element in canvas.Children)

            {

                //< get >

                double old_Left = Canvas.GetLeft(element);

                double old_Top = Canvas.GetTop(element);

                //</ get >



                // < set Left-Top>

                Canvas.SetLeft(element, old_Left * scale_Width);

                Canvas.SetTop(element, old_Top * scale_Height);

                // </ set Left-Top >



                //< set Width-Heigth >

                element.Width = element.Width * scale_Width;

                element.Height = element.Height * scale_Height;

                //</ set Width-Heigth >

            }

            //----</ adapt all children >----



            //----------------</ Canvas_SizeChanged() >----------------

        }
    }
}
