package com.example.trivial;

import androidx.room.Embedded;
import androidx.room.Relation;

import java.util.List;

public class CategoriaConOpciones {
    @Embedded
    private Categoria categoria;

    @Relation(
            parentColumn = "ID",
            entityColumn = "IDCategoria"
    )
    private List<Opcion> opciones;

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public List<Opcion> getOpciones() {
        return opciones;
    }

    public void setOpciones(List<Opcion> opciones) {
        this.opciones = opciones;
    }
}
