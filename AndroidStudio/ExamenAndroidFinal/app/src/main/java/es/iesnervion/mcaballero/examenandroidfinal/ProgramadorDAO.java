package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Query;
import androidx.room.Transaction;

import java.util.List;

@Dao
public interface ProgramadorDAO extends BaseDAO<Programador>{
    @Query("SELECT * FROM Programadores")
    public LiveData<List<Programador>> listadoProgramadores();

    @Query("SELECT * FROM Programadores")
    public LiveData<List<ProgramadorConBugs>> listadoProgramadoresConBugs();

    @Query("SELECT * FROM Programadores WHERE DNI = :DNI")
    @Transaction
    public LiveData<List<ProgramadorConBugs>> listadoProgramadorConBugsPorDNI(int DNI);
}
