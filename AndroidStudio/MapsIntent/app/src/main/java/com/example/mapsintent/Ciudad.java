package com.example.mapsintent;

import androidx.annotation.NonNull;

public class Ciudad {
    //Atributos
    String nombre;
    double latitud;
    double longitud;

    //Constructores

    public Ciudad() {
        this.nombre = "";
        this.latitud = 0;
        this.longitud = 0;
    }

    public Ciudad(String nombre, double latitud, double longitud) {
        this.nombre = nombre;
        this.latitud = latitud;
        this.longitud = longitud;
    }

    //Propiedades

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    //Métodos sobreescritos

    @Override
    public String toString() {
        return this.nombre;
    }
}
