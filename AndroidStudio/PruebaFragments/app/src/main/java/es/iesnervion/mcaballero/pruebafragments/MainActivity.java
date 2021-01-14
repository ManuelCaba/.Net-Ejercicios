package es.iesnervion.mcaballero.pruebafragments;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    MainViewModel vm;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        vm = new ViewModelProvider(this).get(MainViewModel.class);

        View contenedorGeneral;

        contenedorGeneral = findViewById(R.id.contenedorGeneral);

        if(contenedorGeneral != null)
        {
            NavigationFragment frag = new NavigationFragment();

            getSupportFragmentManager().beginTransaction().add(R.id.contenedorGeneral, frag).addToBackStack(null).commit();
        }
    }
}