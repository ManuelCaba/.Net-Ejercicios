package com.example.trivial;

import androidx.room.Insert;
import androidx.room.OnConflictStrategy;

import java.util.List;

public interface BaseDAO<T> {
    @Insert
    public void insertar(T object);

    @Insert
    public void insertarListado(List<T> listado);
}
