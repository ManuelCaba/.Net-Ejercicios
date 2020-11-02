package es.iesnervion.mcaballero.ejemplolistadapter;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ListActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class MainActivity extends ListActivity {

    private static final String[] lista = {"BBDD","PRGRM","ENDES","SINF","FOL"};
    private TextView opcion;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setListAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, lista));
        setContentView(R.layout.activity_main);
        opcion = findViewById(R.id.txvOpcion);
    }

    public void onListItemClick(ListView parent, View v, int position, long id)
    {
        opcion.setText(lista[position]);
    }
}