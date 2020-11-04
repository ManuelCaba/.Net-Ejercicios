package es.iesnervion.mcaballero.listanbaspinner;

public class Equipo {

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

    //Métodos Sobreescritos
    @Override
    public String toString() {
        return equipo;
    }
}
