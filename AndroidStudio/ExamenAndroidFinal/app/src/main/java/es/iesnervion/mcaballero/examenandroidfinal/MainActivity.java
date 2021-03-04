package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    private ViewModel vm;
    final Observer<Integer> observarOpcion = new Observer<Integer>()
    {
        @Override
        public void onChanged(Integer opcion)
        {
            if(opcion == 0)
            {
                getSupportFragmentManager().beginTransaction().replace(R.id.contenedorInsertar, new FragmentInsertProg()).setReorderingAllowed(true).
                        commit();
            }
            else
            {
                getSupportFragmentManager().beginTransaction().replace(R.id.contenedorInsertar, new FragmentInsertBug()).setReorderingAllowed(true).
                        commit();
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        vm = new ViewModelProvider(this).get(ViewModel.class);
        MutableLiveData<Integer> opcion = vm.getOpcion();
        opcion.observe(this, observarOpcion);
    }
}