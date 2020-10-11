package es.iesnervion.mcaballero.sizeletter;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    private EditText etxTexto;
    private float tamanho;

    DisplayMetrics metrics;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        metrics = getApplicationContext().getResources().getDisplayMetrics();
        etxTexto = findViewById(R.id.etxTexto);
        tamanho = etxTexto.getTextSize()/metrics.density;
    }

    public void disminuirLetra(View view)
    {
        tamanho = (float) (tamanho - 0.5);
        etxTexto.setTextSize(tamanho);
    }

    public void aumentarLetra(View view)
    {
        tamanho = (float) (tamanho + 0.5);
        etxTexto.setTextSize(tamanho);
    }
}