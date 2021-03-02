package com.example.trivial;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "Opciones")
public class Opcion {

    @PrimaryKey(autoGenerate = true)
    private int ID;

    @ColumnInfo(name = "Nombre")
    private String nombre;

    @ColumnInfo(name = "Imagen")
    private String imagen;

    public Opcion(String nombre, String imagen, int IDCategoria) {
        this.nombre = nombre;
        this.imagen = imagen;
        this.IDCategoria = IDCategoria;
    }

    private int IDCategoria;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public int getIDCategoria() {
        return IDCategoria;
    }

    public void setIDCategoria(int IDCategoria) {
        this.IDCategoria = IDCategoria;
    }
}
