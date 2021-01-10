package com.example.listanbamvc;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.ArrayList;

public class NBAVM extends ViewModel {

    //Atributos de la clase
    private MutableLiveData<ArrayList<Equipo>>  equipos;

    public NBAVM()
    {
        equipos = new MutableLiveData<>(new ArrayList<>());

        equipos.getValue().add(new Equipo("Boston Celtics", R.drawable.bostonceltics));
        equipos.getValue().add(new Equipo("Brooklyn Nets", R.drawable.brooklynnets));
        equipos.getValue().add(new Equipo("New York Knicks", R.drawable.newyorkknicks));
        equipos.getValue().add(new Equipo("Philadelphia 76ers", R.drawable.philadelphia76ers));
        equipos.getValue().add(new Equipo("Toronto Raptors", R.drawable.torontoraptors));
        equipos.getValue().add(new Equipo("Golden State Warriors", R.drawable.goldenstatewarriors));
        equipos.getValue().add(new Equipo("La Clippers", R.drawable.laclippers));
        equipos.getValue().add(new Equipo("Los Angeles Lakers", R.drawable.losangeleslakers));
        equipos.getValue().add(new Equipo("Phoenix Suns", R.drawable.phoenixsuns));
        equipos.getValue().add(new Equipo("Sacramento Kings", R.drawable.sacramentokings));
    }

    //Propiedades

    public MutableLiveData<ArrayList<Equipo>> getEquipos() {
        return equipos;
    }
}
