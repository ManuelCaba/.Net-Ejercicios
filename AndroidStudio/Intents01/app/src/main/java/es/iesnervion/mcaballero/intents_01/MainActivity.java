package es.iesnervion.mcaballero.intents_01;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.ListView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements AdapterView.OnItemClickListener {

    ListView lvwOpciones;


    ArrayList<String> opciones = new ArrayList<String>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Cargamos las opciones en el arraylist
        opciones.add("TextColour");
        opciones.add("ImageGallery");
        opciones.add("Plus");
        opciones.add("SizeLetter");
        opciones.add("CheckBoxText");
        opciones.add("Calculator");
        opciones.add("Jan-Ken");

        //Creamos un nuevo adapter para la lista
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, opciones);

        lvwOpciones = findViewById(R.id.lvwOpciones);
        lvwOpciones.setAdapter(adapter);

        lvwOpciones.setOnItemClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id)
    {
        Intent intent = null;

        switch (position)
        {
            case 0:
            intent = new Intent(MainActivity.this, TextColour.class);
            break;
            case 1:
                intent = new Intent(MainActivity.this, ImageGallery.class);
                break;
            case 2:
                intent = new Intent(MainActivity.this, Plus.class);
                break;
            case 3:
                intent = new Intent(MainActivity.this, SizeLetter.class);
                break;
            case 4:
                intent = new Intent(MainActivity.this, CheckBoxText.class);
                break;
            case 5:
                intent = new Intent(MainActivity.this, Calculator.class);
                break;
            case 6:
                intent = new Intent(MainActivity.this, JanKen.class);
                break;
        }

        if(intent != null)
        {
            startActivity(intent);
        }
    }
}