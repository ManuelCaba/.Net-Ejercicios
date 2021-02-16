package es.iesnervion.mcaballero.nbaroom;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.ViewModel;

import java.util.List;

public class NBAVM extends AndroidViewModel {

    //Atributos de la clase
    private LiveData<List<NBATeam>> equipos;
    private Repositorio repositorio;

    //Constructores
    public NBAVM(Application application)
    {
        super(application);
        repositorio = new Repositorio(application);
        equipos = repositorio.getListadoNBA();
    }

    //Métodos y propiedades
    public LiveData<List<NBATeam>> getEquipos()
    {
        return equipos;
    }

    public void insertTeam(NBATeam team)
    {
        repositorio.insert(team);
    }
}
