package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

@Entity(tableName = "Bugs")
public class Bug {

    @PrimaryKey(autoGenerate = true)
    private int ID;

    @ColumnInfo(name = "Prioridad")
    private Prioridad prioridad;

    private String IDProgramador;

    public Bug(int ID, Prioridad prioridad, String IDProgramador) {
        this.ID = ID;
        this.prioridad = prioridad;
        this.IDProgramador = IDProgramador;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public Prioridad getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(Prioridad prioridad) {
        this.prioridad = prioridad;
    }

    public String getIDProgramador() {
        return IDProgramador;
    }

    public void setIDProgramador(String IDProgramador) {
        this.IDProgramador = IDProgramador;
    }
}
