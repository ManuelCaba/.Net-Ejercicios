package es.iesnervion.mcaballero.examenandroidfinal;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Entity;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;

@Database(entities = {Programador.class, Bug.class}, version = 1, exportSchema = false)
@TypeConverters(PrioridadConverter.class)
public abstract class ExamenDataBase extends RoomDatabase {
    public abstract ProgramadorDAO ProgramadorDAO();
    public abstract BugDAO BugDao();

    private static ExamenDataBase INSTANCE;

    static ExamenDataBase getDatabase(final Context context) {
        if (INSTANCE == null) {
            synchronized (ExamenDataBase.class) {
                if (INSTANCE == null) {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), ExamenDataBase.class, "ExamenDataBase.db").build();
                }
            }
        }

        return INSTANCE;
    }
}
