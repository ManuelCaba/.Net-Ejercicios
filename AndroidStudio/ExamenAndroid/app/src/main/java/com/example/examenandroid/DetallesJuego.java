package com.example.examenandroid;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class DetallesJuego extends AppCompatActivity {

    TextView nombreJuego;
    TextView descripcionJuego;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detalles_juego);

        Intent intent = getIntent();

        Juego juego = (Juego) intent.getSerializableExtra("result");

        nombreJuego = findViewById(R.id.edtNombreJuego);
        descripcionJuego = findViewById(R.id.edtDescripcionJuego);

        nombreJuego.setText(juego.getNombre());
        descripcionJuego.setText(juego.getDescripcion());
    }
}