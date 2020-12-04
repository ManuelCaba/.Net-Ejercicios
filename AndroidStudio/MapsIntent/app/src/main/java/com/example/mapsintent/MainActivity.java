package com.example.mapsintent;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.NumberPicker;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    Spinner spnCiudades;

    private static final ArrayList<Ciudad> ciudades = new ArrayList<Ciudad>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ciudades.add(new Ciudad("Sevilla",37.3754338,-5.9900775));
        ciudades.add(new Ciudad("Cadiz",36.5164196,-6.2999767));
        ciudades.add(new Ciudad("Jaen",37.780127,-3.8143745));
        ciudades.add(new Ciudad("Malaga",36.764949,-4.4942284));
        ciudades.add(new Ciudad("Granada",37.1809792,-3.6087813));
        ciudades.add(new Ciudad("Cordoba",37.891577,-4.8019948));

        ArrayAdapter<Ciudad> adapter = new ArrayAdapter<Ciudad>(this, android.R.layout.simple_spinner_item, ciudades);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        spnCiudades = findViewById(R.id.spnCiudades);
        spnCiudades.setAdapter(adapter);
    }

    public void buscarCiudad(View view) {
        int position = spnCiudades.getSelectedItemPosition();

        Ciudad ciudadSeleccionada = ciudades.get(position);

        Uri gmmIntentUri = Uri.parse("geo:"+ciudadSeleccionada.latitud+","+ciudadSeleccionada.longitud);
        Intent mapIntent = new Intent(Intent.ACTION_VIEW, gmmIntentUri);
        mapIntent.setPackage("com.google.android.apps.maps");
        if (mapIntent.resolveActivity(getPackageManager()) != null) {
            startActivity(mapIntent);
        }
    }
}