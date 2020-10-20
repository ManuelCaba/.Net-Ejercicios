package es.iesnervion.mcaballero.calculadora;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements RadioGroup.OnCheckedChangeListener {

    private RadioGroup rgRadioGroup;

    private TextView txvResultado;
    private EditText edtNumero1;
    private EditText edtNumero2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        txvResultado = findViewById(R.id.txvResultado);
        edtNumero1 = findViewById(R.id.edtNumero1);
        edtNumero2 = findViewById(R.id.edtNumero2);
        rgRadioGroup = findViewById(R.id.rgRadioGroup);

        rgRadioGroup.setOnCheckedChangeListener(this);
    }

    @Override
    public void onCheckedChanged(RadioGroup group, int checkedId) {

        int numero1;
        int numero2;

        if(edtNumero1.getText().toString().length() == 0)
        {
            edtNumero1.setText("0");
        }

        if(edtNumero2.getText().toString().length() == 0)
        {
            edtNumero2.setText("0");
        }

        numero1 = Integer.parseInt(edtNumero1.getText().toString());
        numero2 = Integer.parseInt(edtNumero2.getText().toString());

        switch(checkedId)
        {
            case R.id.rdbSumar:
                txvResultado.setText(Integer.toString(numero1 + numero2));
            break;
            case R.id.rdbRestar:
                txvResultado.setText(Integer.toString(numero1 - numero2));
            break;
            case R.id.rdbMultiplicar:
                txvResultado.setText(Integer.toString(numero1 * numero2));
            break;
            case R.id.rdbDividir:
                txvResultado.setText(Integer.toString(numero1 / numero2));
            break;
        }
    }
}