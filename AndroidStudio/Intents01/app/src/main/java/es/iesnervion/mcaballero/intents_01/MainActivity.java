package es.iesnervion.mcaballero.intents_01;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    ListView lvwOpciones;


    ArrayList<String> opciones = new ArrayList<String>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Cargamos las opciones en el arraylist
        opciones.add("TextColour");
        opciones.add("ImageGallery");
        opciones.add("AlignButtons");
        opciones.add("Plus");
        opciones.add("SizeLette");
        opciones.add("CheckBoxText");
        opciones.add("Calculadora");
        opciones.add("Jan-Ken");

        //Creamos un nuevo adapter para la lista
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, opciones);

        lvwOpciones = findViewById(R.id.lvwOpciones);
        lvwOpciones.setAdapter(adapter);
    }
}