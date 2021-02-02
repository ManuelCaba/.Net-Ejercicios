package es.iesnervion.mcaballero.jan_ken;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioGroup;
import android.widget.TextView;

import java.util.Random;

public class MainActivity extends AppCompatActivity implements RadioGroup.OnCheckedChangeListener{

    //Declaración de las variables que se van a utilizar
    private RadioGroup rdgOpciones;
    private ImageView imgUser, imgIA;
    private Button btnJugar;
    private TextView txvResultado;
    private LinearLayout lilFinPartida;
    int opcionUsuario = 0;

    int victoriasUsuario, victoriasIA, empates, piedrasUsuario, piedrasIA, papelesUsuario, papelesIA, tijerasUsuario, tijerasIA;
    private SharedPreferences sharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Inicialización de las variables

        sharedPreferences = this.getSharedPreferences("EstadisticasPartida", Context.MODE_PRIVATE);

        rdgOpciones = findViewById(R.id.rdgOpciones);
        imgUser = findViewById(R.id.imgUser);
        imgIA = findViewById(R.id.imgIA);
        btnJugar = findViewById(R.id.btnJugar);
        txvResultado = findViewById(R.id.txvResultado);
        lilFinPartida = findViewById(R.id.lilFinPartida);

        //Cambio de listener
        rdgOpciones.setOnCheckedChangeListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        victoriasUsuario = victoriasIA = empates = piedrasUsuario = piedrasIA = papelesUsuario = papelesIA = tijerasUsuario = tijerasIA = 0;
    }

    /*
        Listener que cambia la imagen imgUser dependiendo de la opción elegida,
        piedra, papel o tijeras.
     */

    @Override
    public void onCheckedChanged(RadioGroup group, int checkedId) {

        switch(checkedId)
        {
            case(R.id.rdbPiedra):
                imgUser.setImageResource(R.drawable.piedra);
                opcionUsuario = 0;
            break;
            case(R.id.rdbPapel):
                imgUser.setImageResource(R.drawable.papel);

                opcionUsuario = 1;
            break;
            case(R.id.rdbTijeras):
                imgUser.setImageResource(R.drawable.tijeras);

                opcionUsuario = 2;
            break;
        }
    }

    /*
        Método que se ejecuta cuando el botón jugar es pulsado.
        Genera aleatoriamente la opción del jugador y la muestra como imagen en imgIA.
        Comprueba el ganador y muestra el resultado y un botón para volver a jugar.
     */
    public void jugar(View view) {
        Random aleatorio = new Random();
        int numeroAleatorio = aleatorio.nextInt(3);

        switch (opcionUsuario)
        {
            case 0:
                piedrasUsuario++;
            break;
            case 1:
                papelesUsuario++;
            break;
            case 2:
                tijerasUsuario++;
        }

        switch (numeroAleatorio)
        {
            case(0):
                imgIA.setImageResource(R.drawable.piedra);

                piedrasIA++;


                switch (opcionUsuario)
                {
                    case 0:
                        txvResultado.setText(R.string.play_tie);
                        empates++;
                    break;
                    case 1:
                        txvResultado.setText(R.string.play_won);
                        victoriasUsuario++;
                    break;
                    case 2:
                        txvResultado.setText(R.string.play_lost);
                        victoriasIA++;
                    break;
                }

            break;
            case(1):
                imgIA.setImageResource(R.drawable.papel);

                papelesIA++;

                switch (opcionUsuario)
                {
                    case 0:
                        txvResultado.setText(R.string.play_lost);

                        victoriasIA++;
                    break;
                    case 1:
                        txvResultado.setText(R.string.play_tie);

                        empates++;
                    break;
                    case 2:
                        txvResultado.setText(R.string.play_won);

                        victoriasUsuario++;
                    break;
                }

            break;
            case(2):
                imgIA.setImageResource(R.drawable.tijeras);

                tijerasIA++;

                switch (opcionUsuario)
                {
                    case 0:
                        txvResultado.setText(R.string.play_won);

                        victoriasUsuario++;
                    break;
                    case 1:
                        txvResultado.setText(R.string.play_lost);

                        victoriasIA++;
                    break;
                    case 2:
                        txvResultado.setText(R.string.play_tie);

                        empates++;
                    break;
                }

            break;
        }


        //Se muestra el layout de fin de partida
        lilFinPartida.setVisibility(View.VISIBLE);

        //Desactivamos el botón jugar
        btnJugar.setClickable(false);
    }

    /*
    Método que se ejecuta cuando el botón nueva partida es pulsado.
    Comienza una nueva partida.
    */
    public void nuevaPartida(View view) {

        //Limpiamos la elección de la IA
        imgIA.setImageResource(0);

        //Activamos el botón jugar
        btnJugar.setClickable(true);

        //Se pone invisible el layout de fin de partida
        lilFinPartida.setVisibility(View.INVISIBLE);
    }

    public void estadisticas(View view) {

        int victoriasUsuario, victoriasIA, empates, piedrasUsuario, piedrasIA, papelesUsuario, papelesIA, tijerasUsuario, tijerasIA;
        Intent intentEstadisticas = new Intent(MainActivity.this, Estadisticas.class);

        victoriasUsuario = sharedPreferences.getInt("Victorias Usuario", 0);
        victoriasIA = sharedPreferences.getInt("Victorias IA", 0);
        empates = sharedPreferences.getInt("Empates", 0);
        piedrasUsuario = sharedPreferences.getInt("Piedras Usuario", 0);
        piedrasIA = sharedPreferences.getInt("Piedras IA", 0);
        papelesUsuario = sharedPreferences.getInt("Papeles Usuario", 0);
        papelesIA = sharedPreferences.getInt("Papeles IA", 0);
        tijerasUsuario = sharedPreferences.getInt("Tijeras Usuario", 0);
        tijerasIA = sharedPreferences.getInt("Tijeras  IA", 0);

        SharedPreferences.Editor editor = sharedPreferences.edit();

        if(this.victoriasUsuario != 0)
        {
            editor.putInt("Victorias Usuario", victoriasUsuario + this.victoriasUsuario);
        }

        if(this.victoriasIA != 0)
        {
            editor.putInt("Victorias IA", victoriasIA + this.victoriasIA);
        }

        if(this.empates != 0)
        {
            editor.putInt("Empates", empates + this.empates);
        }

        if(this.piedrasUsuario != 0)
        {
            editor.putInt("Piedras Usuario", piedrasUsuario + this.piedrasUsuario);
        }

        if(this.piedrasIA != 0)
        {
            editor.putInt("Piedras IA", piedrasIA + this.piedrasIA);
        }

        if(this.papelesUsuario != 0)
        {
            editor.putInt("Papeles Usuario", papelesUsuario + this.papelesUsuario);
        }

        if(this.papelesIA != 0)
        {
            editor.putInt("Papeles IA", papelesIA + this.papelesIA);
        }
        if(this.tijerasUsuario != 0)
        {
            editor.putInt("Tijeras Usuario", tijerasUsuario + this.tijerasUsuario);
        }

        if(this.tijerasIA != 0)
        {
            editor.putInt("Tijeras IA", tijerasIA + this.tijerasIA);
        }

        editor.apply();

        startActivity(intentEstadisticas);

    }
}