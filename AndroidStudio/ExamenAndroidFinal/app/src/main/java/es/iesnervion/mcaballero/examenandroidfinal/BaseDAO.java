package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.room.Insert;

import java.util.List;

public interface BaseDAO<T> {
    @Insert
    public void insertar(T object);

    @Insert
    public void insertarListado(List<T> listado);
}
