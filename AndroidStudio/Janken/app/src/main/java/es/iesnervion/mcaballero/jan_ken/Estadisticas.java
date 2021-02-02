package es.iesnervion.mcaballero.jan_ken;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class Estadisticas extends AppCompatActivity {

    private TextView txvVictoriasUsuario;
    private TextView txvVictoriasIA;
    private TextView txvEmpates;
    private TextView txvPiedrasUsuario;
    private TextView txvPiedrasIA;
    private TextView txvPapelesUsuario;
    private TextView txvPapelesIA;
    private TextView txvTijerasUsuario;
    private TextView txvTijerasIA;

    private SharedPreferences sharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_estadisticas);

        //Inicialización de los atributos
        txvVictoriasUsuario = findViewById(R.id.txvVictoriasUsuario);
        txvVictoriasIA = findViewById(R.id.txvVictoriasIA);
        txvEmpates = findViewById(R.id.txvEmpates);
        txvPiedrasUsuario = findViewById(R.id.txvPiedrasUsuario);
        txvPiedrasIA = findViewById(R.id.txvPiedrasIA);
        txvPapelesUsuario = findViewById(R.id.txvPapelesUsuario);
        txvPapelesIA = findViewById(R.id.txvPapelesIA);
        txvTijerasUsuario = findViewById(R.id.txvTijerasUsuario);
        txvTijerasIA = findViewById(R.id.txvTijerasIA);

        sharedPreferences = this.getSharedPreferences("EstadisticasPartida", Context.MODE_PRIVATE);

        txvVictoriasUsuario.setText(Integer.toString(sharedPreferences.getInt("Victorias Usuario", 0)));
        txvVictoriasIA.setText(Integer.toString(sharedPreferences.getInt("Victorias IA", 0)));
        txvEmpates.setText(Integer.toString(sharedPreferences.getInt("Empates", 0)));
        txvPiedrasUsuario.setText(Integer.toString(sharedPreferences.getInt("Piedras Usuario", 0)));
        txvPiedrasIA.setText(Integer.toString(sharedPreferences.getInt("Piedras IA", 0)));
        txvPapelesUsuario.setText(Integer.toString(sharedPreferences.getInt("Papeles Usuario", 0)));
        txvPapelesIA.setText(Integer.toString(sharedPreferences.getInt("Papeles IA", 0)));
        txvTijerasUsuario.setText(Integer.toString(sharedPreferences.getInt("Tijeras Usuario", 0)));
        txvTijerasIA.setText(Integer.toString(sharedPreferences.getInt("Tijeras IA", 0)));
    }

    public void volver(View view) {
        finish();
    }
}