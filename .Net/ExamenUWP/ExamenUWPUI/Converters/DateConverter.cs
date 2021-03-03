using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml.Data;

namespace ExamenUWPUI.Converters
{
    public class DateConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, string language)
        {
            DateTime fecha = (DateTime)value;

            if(fecha.Year < 1900)
            {
                fecha = new DateTime(1900, fecha.Month, fecha.Day);
            }

            DateTimeOffset fechaDevuelta = new DateTimeOffset(fecha);

            return fechaDevuelta;
        }

        public object ConvertBack(object value, Type targetType, object parameter, string language)
        {
            DateTimeOffset fechaOffSet = (DateTimeOffset)value;
            DateTime fecha = fechaOffSet.DateTime;

            return fecha;
        }
    }
}
