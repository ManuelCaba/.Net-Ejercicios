package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.room.TypeConverter;

public class PrioridadConverter {
        @TypeConverter
        public static String enumToString(Prioridad value) {
            return value == null ? null : value.toString();
        }

        @TypeConverter
        public static Prioridad StringToEnum(String value) {
            return value == null ? null : Prioridad.valueOf("value");
        }
}
