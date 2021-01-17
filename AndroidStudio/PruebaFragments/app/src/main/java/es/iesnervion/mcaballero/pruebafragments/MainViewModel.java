package es.iesnervion.mcaballero.pruebafragments;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class MainViewModel extends ViewModel {

    private MutableLiveData<Integer> numeroBoton = new MutableLiveData<>();

    public MainViewModel()
    {
        numeroBoton.setValue(0);
    }

    public MutableLiveData<Integer> getNumeroBoton()
    {
        return numeroBoton;
    }

    public void setNumeroBoton(int numeroBoton)
    {
        this.numeroBoton.setValue(numeroBoton);
    }
}
