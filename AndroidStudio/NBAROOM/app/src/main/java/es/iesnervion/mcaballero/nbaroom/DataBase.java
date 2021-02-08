package es.iesnervion.mcaballero.nbaroom;

import androidx.room.Database;

@Database(entities = {NBATeam.class}, version = 1)
public abstract class DataBase {
    public abstract TeamDAO teamDAO();
}
