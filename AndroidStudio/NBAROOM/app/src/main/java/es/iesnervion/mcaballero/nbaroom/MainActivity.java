package es.iesnervion.mcaballero.nbaroom;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.room.Database;

import android.os.Bundle;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    final Observer<List<NBATeam>> observarListado = new Observer<List<NBATeam>>()
    {
        @Override
        public void onChanged(List<NBATeam> listado)
        {
            System.out.println(listado);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Repositorio repositorio = new Repositorio(this.getApplication());
        repositorio.insert(new NBATeam("Manuel"));
        LiveData<List<NBATeam>> listadoNBA = repositorio.getListadoNBA();
        listadoNBA.observe(this, observarListado);
    }
}