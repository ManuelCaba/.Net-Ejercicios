package es.iesnervion.mcaballero.intents_01;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioGroup;
import android.widget.TextView;

import java.util.Random;

public class JanKen extends AppCompatActivity implements RadioGroup.OnCheckedChangeListener{

    //Declaración de las variables que se van a utilizar
    private RadioGroup rdgOpciones;
    private ImageView imgUser, imgIA;
    private Button btnJugar;
    private TextView txvResultado;
    private LinearLayout lilFinPartida;
    int opcionUsuario = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.janken);

        //Inicialización de las variables
        rdgOpciones = findViewById(R.id.rdgOpciones);
        imgUser = findViewById(R.id.imgUser);
        imgIA = findViewById(R.id.imgIA);
        btnJugar = findViewById(R.id.btnJugar);
        txvResultado = findViewById(R.id.txvResultado);
        lilFinPartida = findViewById(R.id.lilFinPartida);

        //Cambio de listener
        rdgOpciones.setOnCheckedChangeListener(this);
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

        switch (numeroAleatorio)
        {
            case(0):
                imgIA.setImageResource(R.drawable.piedra);


                switch (opcionUsuario)
                {
                    case 0:
                        txvResultado.setText(R.string.play_tie);
                        break;
                    case 1:
                        txvResultado.setText(R.string.play_won);
                        break;
                    case 2:
                        txvResultado.setText(R.string.play_lost);
                        break;
                }

                break;
            case(1):
                imgIA.setImageResource(R.drawable.papel);

                switch (opcionUsuario)
                {
                    case 0:
                        txvResultado.setText(R.string.play_lost);
                        break;
                    case 1:
                        txvResultado.setText(R.string.play_tie);
                        break;
                    case 2:
                        txvResultado.setText(R.string.play_won);
                        break;
                }

                break;
            case(2):
                imgIA.setImageResource(R.drawable.tijeras);

                switch (opcionUsuario)
                {
                    case 0:
                        txvResultado.setText(R.string.play_won);
                        break;
                    case 1:
                        txvResultado.setText(R.string.play_lost);
                        break;
                    case 2:
                        txvResultado.setText(R.string.play_tie);
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
}