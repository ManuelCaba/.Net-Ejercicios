package es.iesnervion.mcaballero.nbaintent;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    public final static int REQ_CODE_EQUIPO = 1;

    ImageView imwLogo;
    TextView txwEquipo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imwLogo = findViewById(R.id.imwLogoEquipo);
        txwEquipo = findViewById(R.id.txwNombreEquipo);
    }

    protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQ_CODE_EQUIPO) {

            Equipo equipo = (Equipo) data.getSerializableExtra("result");

            imwLogo.setImageResource(equipo.getLogo());
            txwEquipo.setText(equipo.getEquipo());
        }
    }

    public void elegirEquipo(View view) {
        Intent intent = new Intent(MainActivity.this, ListaEquipos.class);

        startActivityForResult(intent, REQ_CODE_EQUIPO);
    }
}