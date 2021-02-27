package com.example.trivial;

import android.app.Application;
import android.os.AsyncTask;

import androidx.lifecycle.LiveData;

import java.util.List;

public class Repositorio {
    private CategoriaDAO categoriaDAO;
    private LiveData<List<CategoriaConOpciones>> listadoCategoriasConOpciones;

    public Repositorio(Application application) {
        TrivialDataBase db = TrivialDataBase.getDatabase(application);
        categoriaDAO = db.categoriaDAO();
        listadoCategoriasConOpciones = categoriaDAO.obtenerCategoriasConOpciones();
    }

    LiveData<List<CategoriaConOpciones>> getListadoCategoriasConOpciones() {
        return listadoCategoriasConOpciones;
    }
}
