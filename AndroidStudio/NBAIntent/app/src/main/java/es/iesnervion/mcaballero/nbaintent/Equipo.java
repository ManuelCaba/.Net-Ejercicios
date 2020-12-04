package es.iesnervion.mcaballero.nbaintent;

import java.io.Serializable;

public class Equipo implements Serializable {

    //Atributos de la clase
    private String equipo;
    private int logo;

    //Constructores
    public Equipo(String equipo, int logo)
    {
        this.equipo = equipo;
        this.logo = logo;
    }

    //Propiedades
    public String getEquipo()
    {
        return equipo;
    }

    public void setEquipo(String equipo)
    {
        this.equipo = equipo;
    }

    public int getLogo()
    {
        return logo;
    }

    public void setLogo(int logo)
    {
        this.logo = logo;
    }
}