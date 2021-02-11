package es.iesnervion.mcaballero.nbaroom;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

@Database(entities = {NBATeam.class}, version = 1)
public abstract class DataBase extends RoomDatabase {

    public abstract TeamDAO teamDAO();

    private static DataBase INSTANCE;

    static DataBase getDatabase(final Context context)
    {
        if(INSTANCE == null)
        {
            synchronized (DataBase.class)
            {
                if(INSTANCE == null)
                {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), DataBase.class, "NBADataBase.db").build();
                }
            }
        }

        return INSTANCE;
    }
}
