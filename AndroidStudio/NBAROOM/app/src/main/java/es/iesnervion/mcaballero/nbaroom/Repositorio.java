package es.iesnervion.mcaballero.nbaroom;

import android.app.Application;
import android.content.ContentProvider;
import android.content.Context;
import android.os.AsyncTask;

import androidx.lifecycle.LiveData;

import java.util.List;

public class Repositorio {

    private TeamDAO teamDAO;
    private LiveData<List<NBATeam>> listadoNBA;

    public Repositorio(Application application) {
        DataBase db = DataBase.getDatabase(application);
        teamDAO = db.teamDAO();
        listadoNBA = teamDAO.obtenerListaEquiposCompleta();
    }

    LiveData<List<NBATeam>> getListadoNBA() {
        return listadoNBA;
    }

    public void insert (NBATeam team) {
        new insertAsyncTask(teamDAO).execute(team);
    }

    private static class insertAsyncTask extends AsyncTask<NBATeam, Void, Void> {

        private TeamDAO mAsyncTaskDao;

        insertAsyncTask(TeamDAO dao) {
            mAsyncTaskDao = dao;
        }

        @Override
        protected Void doInBackground(final NBATeam... params) {
            mAsyncTaskDao.insertarEquipo(params[0]);
            return null;
        }
    }
}
