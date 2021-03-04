package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Query;

import java.util.List;

@Dao
public interface BugDAO extends BaseDAO<Bug> {

    @Query("SELECT * FROM Bugs")
    public LiveData<List<Bug>> obtenerListadoBugs();
}
