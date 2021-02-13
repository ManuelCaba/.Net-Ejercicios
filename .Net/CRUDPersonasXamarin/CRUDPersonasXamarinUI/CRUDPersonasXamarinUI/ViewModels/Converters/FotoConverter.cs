using System;
using System.Collections.Generic;
using System.IO;
using System.Globalization;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml.Data;
using Xamarin.Forms;

namespace CRUDPersonasXamarinUI.ViewModels.Converters
{
    class FotoConverter: Xamarin.Forms.IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo language)
        {
            byte[] foto = (byte[]) value;
            ImageSource fotoSource = null;

            if(foto != null)
            {
                fotoSource = ImageSource.FromStream(() => new MemoryStream(foto));
            }

            return fotoSource;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
