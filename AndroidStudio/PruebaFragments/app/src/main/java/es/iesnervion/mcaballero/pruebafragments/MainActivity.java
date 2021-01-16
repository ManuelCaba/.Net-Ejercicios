package es.iesnervion.mcaballero.pruebafragments;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    MainViewModel vm;

    final Observer<Integer> observerNumeroBoton = new Observer<Integer>()
    {
        @Override
        public void onChanged(Integer integer)
        {
            if(vm.getNumeroBoton().getValue().intValue() != 0)
            {
                getSupportFragmentManager().beginTransaction().replace(R.id.contenedorGeneral, new DetailsFragment()).commit();
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        vm = new ViewModelProvider(this).get(MainViewModel.class);

        View contenedorGeneral;

        contenedorGeneral = findViewById(R.id.contenedorGeneral);
        vm.getNumeroBoton().observe(this, observerNumeroBoton);

        if(contenedorGeneral != null)
        {
            NavigationFragment frag = new NavigationFragment();

            getSupportFragmentManager().beginTransaction().add(R.id.contenedorGeneral, frag).addToBackStack(frag.getClass().getName()).commit();
        }
    }
}