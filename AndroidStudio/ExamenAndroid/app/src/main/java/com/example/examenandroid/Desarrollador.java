package com.example.examenandroid;

import java.io.Serializable;

public class Desarrollador implements Serializable {
    //Atributos

    private String nombre;
    private int logo;
    private int anhoFundacion;
    private String descripcion;

    //Constructores


    public Desarrollador() {
    }

    public Desarrollador(String nombre, int logo, int anhoFundacion, String descripcion) {
        this.nombre = nombre;
        this.logo = logo;
        this.anhoFundacion = anhoFundacion;
        this.descripcion = descripcion;
    }


    //Propiedades

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getLogo() {
        return logo;
    }

    public void setLogo(int logo) {
        this.logo = logo;
    }

    public int getAnhoFundacion() {
        return anhoFundacion;
    }

    public void setAnhoFundacion(int anhoFundacion) {
        this.anhoFundacion = anhoFundacion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
