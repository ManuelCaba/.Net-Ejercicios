package es.iesnervion.mcaballero.examenandroidfinal;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;

import java.util.List;

public class ViewModel extends AndroidViewModel {

    private LiveData<List<Programador>> programadores;
    private LiveData<List<ProgramadorConBugs>> programadoresConBugs;
    private Repositorio repositorio;
    private MutableLiveData<Integer> opcion;
    private Integer posicionProgramadorSeleccionado;

    public ViewModel(@NonNull Application application) {
        super(application);
        repositorio = new Repositorio(application);
        programadores = repositorio.getListadoProgramadores();
        programadoresConBugs = repositorio.getListadoProgramadorConBugs();
        opcion = new MutableLiveData<>(0);
    }

    public LiveData<List<Programador>> getProgramadores() {
        return programadores;
    }

    public LiveData<List<ProgramadorConBugs>> getProgramadoresConBugs() {
        return programadoresConBugs;
    }

    public void insertarBug(Bug bug)
    {
        repositorio.insertarBug(bug);
    }

    public void insertarProgramador(Programador programador)
    {
        repositorio.insertarProgramador(programador);
    }

    public MutableLiveData<Integer> getOpcion() {
        return opcion;
    }

    public void setOpcion(int opcion) {
        this.opcion.postValue(opcion);
    }

    public Integer getPosicionProgramadorSeleccionado() {
        return posicionProgramadorSeleccionado;
    }

    public void setPosicionProgramadorSeleccionado(Integer posicionProgramadorSeleccionado) {
        this.posicionProgramadorSeleccionado = posicionProgramadorSeleccionado;
    }
}
