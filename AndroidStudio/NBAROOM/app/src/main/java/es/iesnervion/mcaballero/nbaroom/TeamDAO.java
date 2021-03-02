package es.iesnervion.mcaballero.nbaroom;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import java.util.List;

@Dao
public interface TeamDAO {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insertarEquipo(NBATeam equipo);

    @Query("SELECT * FROM Teams")
    public LiveData<List<NBATeam>> obtenerListaEquiposCompleta();

    @Query("SELECT * FROM Teams WHERE ID IN (:id)")
    public LiveData<List<NBATeam>> obtenerListaEquiposPorID(int[] id);
}
