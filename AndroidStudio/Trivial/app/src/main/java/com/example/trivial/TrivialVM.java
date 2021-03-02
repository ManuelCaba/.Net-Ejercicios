package com.example.trivial;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import java.util.List;

public class TrivialVM extends AndroidViewModel {

    //Atributos de la clase
    private LiveData<List<CategoriaConOpciones>> categoriasConOpciones;
    private Repositorio repositorio;

    //Constructores
    public TrivialVM(Application application)
    {
        super(application);
        repositorio = new Repositorio(application);
        categoriasConOpciones = repositorio.getListadoCategoriasConOpciones();
    }

    //Métodos y propiedades
    public LiveData<List<CategoriaConOpciones>> getListadoCategoriasConOpciones ()
    {
        return categoriasConOpciones;
    }
}
