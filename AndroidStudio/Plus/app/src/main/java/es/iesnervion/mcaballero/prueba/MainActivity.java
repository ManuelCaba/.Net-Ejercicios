package es.iesnervion.mcaballero.prueba;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private EditText etxNumero1;
    private EditText etxNumero2;
    private TextView txvResult;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etxNumero1 = findViewById(R.id.etxNumero1);
        etxNumero2 = findViewById(R.id.etxNumero2);
        txvResult = findViewById(R.id.txvResult);
    }

    public void Sumar(View view)
    {
        double numero1, numero2;

        if(this.etxNumero1.getText().length() == 0)
        {
            numero1 = 0;
        }
        else
        {
            numero1 = Double.parseDouble(this.etxNumero1.getText().toString());
        }

        if(this.etxNumero2.getText().length() == 0)
        {
            numero2 = 0;
        }
        else
        {
            numero2 = Double.parseDouble(this.etxNumero1.getText().toString());
        }

        double suma = numero1 + numero2;

        this.txvResult.setText(Double.toString(suma));
    }
}