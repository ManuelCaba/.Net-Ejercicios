package es.iesnervion.mcaballero.nbaroom;

import androidx.lifecycle.LiveData;

import java.util.List;

public class Repositorio {

    public void insertarEquipo(NBATeam equipo)
    {
        TeamDAO.insertarEquipo();
    }
}
