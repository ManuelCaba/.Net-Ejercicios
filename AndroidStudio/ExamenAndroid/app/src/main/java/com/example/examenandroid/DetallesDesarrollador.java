package com.example.examenandroid;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class DetallesDesarrollador extends AppCompatActivity {

    ImageView logo;
    TextView nombre;
    TextView year;
    TextView descripcion;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detalles_desarrollador);

        Intent intent = getIntent();

        Desarrollador desarrollador = (Desarrollador) intent.getSerializableExtra("result");

        logo = findViewById(R.id.imgDesarrollador);
        nombre = findViewById(R.id.edtNombre);
        year = findViewById(R.id.edtYear);
        descripcion = findViewById(R.id.edtDescripcion);

        logo.setImageResource(desarrollador.getLogo());
        nombre.setText(desarrollador.getNombre());
        year.setText(Integer.toString(desarrollador.getAnhoFundacion()));
        descripcion.setText(desarrollador.getDescripcion());
    }


    public void guardarCambios(View view) {
        //Aqui deberian guardarse los cambios en una bbdd
        finish();
    }
}