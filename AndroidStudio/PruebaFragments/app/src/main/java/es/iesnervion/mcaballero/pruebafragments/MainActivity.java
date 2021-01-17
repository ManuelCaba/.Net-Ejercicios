package es.iesnervion.mcaballero.pruebafragments;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.lifecycle.ViewModelProviders;

import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    private MainViewModel vm;
    private View contenedorGeneral;

    final Observer<Integer> observerNumeroBoton = new Observer<Integer>()
    {
        @Override
        public void onChanged(Integer integer)
        {
            if(contenedorGeneral != null && vm.getNumeroBoton().getValue().intValue() != 0)
            {
                getSupportFragmentManager().beginTransaction().replace(R.id.contenedorGeneral, new DetailsFragment()).addToBackStack(NavigationFragment.class.getName()).commit();
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        vm = new ViewModelProvider(this).get(MainViewModel.class);

        contenedorGeneral = findViewById(R.id.contenedorGeneral);
        vm.getNumeroBoton().observe(this, observerNumeroBoton);

        if(contenedorGeneral != null)
        {
            NavigationFragment frag = new NavigationFragment();

            getSupportFragmentManager().beginTransaction().add(R.id.contenedorGeneral, frag).commit();
        }
    }
}