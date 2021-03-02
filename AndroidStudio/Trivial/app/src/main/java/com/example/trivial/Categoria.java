package com.example.trivial;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "Categorias")
public class Categoria {

    @PrimaryKey(autoGenerate = true)
    private int ID;

    @ColumnInfo(name = "Categoria")
    private String categoria;

    public Categoria(String categoria) {
        this.ID = ID;
        this.categoria = categoria;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
}
