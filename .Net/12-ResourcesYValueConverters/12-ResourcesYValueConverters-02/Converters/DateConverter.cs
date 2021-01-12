using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.UI.Xaml.Data;

namespace _12_ResourcesYValueConverters_02.Converters
{
    class DateConverter:IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, string language)
        {
            DateTime dateValue = (DateTime) value;

            String dateString = dateValue.ToString("dd/MM/yyyy");

            return dateString;
        }

        public object ConvertBack(object value, Type targetType, object parameter, string language)
        {
            String dateString = value as String;

            DateTime dateValue = DateTime.Parse(dateString);

            return dateValue;
        }
    }
}
