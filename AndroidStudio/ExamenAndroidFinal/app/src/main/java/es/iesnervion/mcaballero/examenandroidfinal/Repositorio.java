package es.iesnervion.mcaballero.examenandroidfinal;

import android.app.Application;

import androidx.lifecycle.LiveData;

import java.util.List;
import java.util.concurrent.Executors;

public class Repositorio {
    private ProgramadorDAO programadorDAO;
    private BugDAO bugDAO;
    //private LiveData<List<ProgramadorConBugs>> listadoProgramadorConBugs;
    private LiveData<List<Programador>> listadoProgramadores;

    public Repositorio(Application application) {
        ExamenDataBase db = ExamenDataBase.getDatabase(application);
        programadorDAO = db.ProgramadorDAO();
        bugDAO = db.BugDao();
        listadoProgramadores = programadorDAO.listadoProgramadores();
    }

    public LiveData<List<Programador>> getListadoProgramadores() {
        return listadoProgramadores;
    }

    public void insertarBug(Bug bug)
    {

        Executors.newSingleThreadExecutor().execute(()->bugDAO.insertar(bug));

    }

    public void insertarProgramador(Programador programador)
    {
        Executors.newSingleThreadExecutor().execute(()->programadorDAO.insertar(programador));
    }
}
