package com.example.trivial;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Query;

import java.util.List;

@Dao
public interface CategoriaDAO extends BaseDAO<Categoria> {

    @Query("SELECT * FROM Categorias")
    public LiveData<List<Categoria>> obtenerListadoCategoriasCompleto();

    @Query("SELECT * FROM Categorias")
    public LiveData<List<CategoriaConOpciones>> obtenerCategoriasConOpciones();
}
