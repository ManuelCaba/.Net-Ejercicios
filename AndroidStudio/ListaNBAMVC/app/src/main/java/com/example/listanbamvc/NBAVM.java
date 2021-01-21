package com.example.listanbamvc;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.ArrayList;

public class NBAVM extends ViewModel {

    //Atributos de la clase
    private ArrayList<Equipo> equipos;

    public NBAVM()
    {
        equipos = new ArrayList<>();

        equipos.add(new Equipo("Boston Celtics", R.drawable.bostonceltics));
        equipos.add(new Equipo("Brooklyn Nets", R.drawable.brooklynnets));
        equipos.add(new Equipo("New York Knicks", R.drawable.newyorkknicks));
        equipos.add(new Equipo("Philadelphia 76ers", R.drawable.philadelphia76ers));
        equipos.add(new Equipo("Toronto Raptors", R.drawable.torontoraptors));
        equipos.add(new Equipo("Golden State Warriors", R.drawable.goldenstatewarriors));
        equipos.add(new Equipo("La Clippers", R.drawable.laclippers));
        equipos.add(new Equipo("Los Angeles Lakers", R.drawable.losangeleslakers));
        equipos.add(new Equipo("Phoenix Suns", R.drawable.phoenixsuns));
        equipos.add(new Equipo("Sacramento Kings", R.drawable.sacramentokings));
    }

    //Propiedades

    public ArrayList<Equipo> getEquipos() {
        return equipos;
    }
}
