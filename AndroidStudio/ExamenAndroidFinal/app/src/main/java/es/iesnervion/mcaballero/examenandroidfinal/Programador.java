package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.util.jar.Attributes;

@Entity(tableName = "Programadores")
public class Programador {

    @ColumnInfo(name = "Nombre")
    private String nombre;

    @PrimaryKey
    @NonNull
    private String DNI;

    public Programador(String nombre, String DNI) {
        this.nombre = nombre;
        this.DNI = DNI;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    @Override
    public String toString() {
        return nombre;
    }
}
