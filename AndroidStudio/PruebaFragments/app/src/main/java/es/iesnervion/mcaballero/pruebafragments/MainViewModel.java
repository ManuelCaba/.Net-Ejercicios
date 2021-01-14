package es.iesnervion.mcaballero.pruebafragments;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class MainViewModel extends ViewModel {

    private MutableLiveData<Integer> numeroBoton;

    public MainViewModel()
    {
        numeroBoton.postValue(new Integer(0));
    }

    public MutableLiveData<Integer> getNumeroBoton()
    {
        return numeroBoton;
    }
}
