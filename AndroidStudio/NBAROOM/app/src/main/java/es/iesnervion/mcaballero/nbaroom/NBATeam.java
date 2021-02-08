package es.iesnervion.mcaballero.nbaroom;

import androidx.room.*;

@Entity (tableName = "Teams")
public class NBATeam {
    @PrimaryKey(autoGenerate = true)
    private int ID;
    @ColumnInfo(name = "Nombre")
    private String nombre;
    @ColumnInfo(name = "Logo")
    private String logo;

    public int getID() {
        return ID;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }
}
