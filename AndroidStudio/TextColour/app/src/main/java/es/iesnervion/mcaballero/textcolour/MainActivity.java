package es.iesnervion.mcaballero.textcolour;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    private EditText etxTexto;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etxTexto = findViewById(R.id.etxTexto);
    }

    public void colorearRojo(View view)
    {
        this.etxTexto.setTextColor(Color.parseColor("#EF2917"));
    }

    public void colorearAzul(View view)
    {
        this.etxTexto.setTextColor(Color.parseColor("#006992"));
    }

    public void colorearVerde(View view)
    {
        this.etxTexto.setTextColor(Color.parseColor("#51CB20"));
    }
}