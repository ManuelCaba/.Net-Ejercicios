package es.iesnervion.mcaballero.intents_01;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class Calculator extends AppCompatActivity implements View.OnClickListener {

    //Botones
    private Button btnPunto;
    private Button btn0;
    private Button btnComa;
    private Button btnIgual;
    private Button btn1;
    private Button btn2;
    private Button btn3;
    private Button btnSuma;
    private Button btn4;
    private Button btn5;
    private Button btn6;
    private Button btnResta;
    private Button btn7;
    private Button btn8;
    private Button btn9;
    private Button btnMultiplicacion;
    private Button btnAC;
    private Button btnDivision;

    double resultado = 0;
    String operador = "0", mostrar = "0", reserva = "0";

    //TextViews Solucion
    private TextView txvSolucion;
    private TextView txvOperaciones;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.calculator);

        //Inicializar botones
        btnPunto = findViewById(R.id.btnPunto);
        btn0 = findViewById(R.id.btn0);
        btnComa = findViewById(R.id.btnComa);
        btnIgual = findViewById(R.id.btnIgual);
        btn1 = findViewById(R.id.btn1);
        btn2 = findViewById(R.id.btn2);
        btn3 = findViewById(R.id.btn3);
        btnSuma = findViewById(R.id.btnSuma);
        btn4 = findViewById(R.id.btn4);
        btn5 = findViewById(R.id.btn5);
        btn6 = findViewById(R.id.btn6);
        btnResta = findViewById(R.id.btnResta);
        btn7 = findViewById(R.id.btn7);
        btn8 = findViewById(R.id.btn8);
        btn9 = findViewById(R.id.btn9);
        btnMultiplicacion = findViewById(R.id.btnMultiplicacion);
        btnAC = findViewById(R.id.btnAC);
        btnDivision = findViewById(R.id.btnDivision);

        //Inicializar TextViews
        txvSolucion = findViewById(R.id.txvSolucion);
        txvOperaciones = findViewById(R.id.txvOperaciones);

        btnPunto.setOnClickListener(this);
        btn0.setOnClickListener(this);
        btnComa.setOnClickListener(this);
        btnIgual.setOnClickListener(this);
        btn1.setOnClickListener(this);
        btn2.setOnClickListener(this);
        btn3.setOnClickListener(this);
        btnSuma.setOnClickListener(this);
        btn4.setOnClickListener(this);
        btn5.setOnClickListener(this);
        btn6.setOnClickListener(this);
        btnResta.setOnClickListener(this);
        btn7.setOnClickListener(this);
        btn8.setOnClickListener(this);
        btn9.setOnClickListener(this);
        btnMultiplicacion.setOnClickListener(this);
        btnAC.setOnClickListener(this);
        btnDivision.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        Button btnActual = findViewById(v.getId());
        double resultado = 0;

        switch(v.getId())
        {
            case R.id.btnPunto:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + ".";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btnComa:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + ".";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn0:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "0";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn1:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "1";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn2:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "2";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn3:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "3";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn4:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "4";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn5:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "5";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn6:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "6";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn7:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "7";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn8:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "8";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btn9:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "9";
                txvOperaciones.setText(mostrar);
                break;
            case R.id.btnSuma:
                reserva = txvOperaciones.getText().toString();
                operador = "+";
                txvOperaciones.setText("");
                break;
            case R.id.btnResta:
                reserva = txvOperaciones.getText().toString();
                operador = "-";
                txvOperaciones.setText("");
                break;
            case R.id.btnMultiplicacion:
                reserva = txvOperaciones.getText().toString();
                operador = "*";
                txvOperaciones.setText("");
                break;
            case R.id.btnDivision:
                reserva = txvOperaciones.getText().toString();
                operador = "/";
                txvOperaciones.setText("");
                break;
            case R.id.btnAC:
                mostrar = "";
                txvOperaciones.setText(mostrar);
                txvSolucion.setText(mostrar);
                reserva = "";
                operador = "";
                break;
            case R.id.btnIgual:
                mostrar = txvOperaciones.getText().toString();
                mostrar = mostrar + "1";
                if(operador.equals("-")){
                    this.resultado = Double.parseDouble(reserva) - Double.parseDouble(txvOperaciones.getText().toString());
                    txvOperaciones.setText(String.valueOf(this.resultado));
                    txvSolucion.setText(String.valueOf(this.resultado));
                }
                if(operador.equals("+")){
                    this.resultado = Double.parseDouble(reserva) + Double.parseDouble(txvOperaciones.getText().toString());
                    txvOperaciones.setText(String.valueOf(this.resultado));
                    txvSolucion.setText(String.valueOf(this.resultado));
                }
                if(operador.equals("/")){
                    this.resultado = Double.parseDouble(reserva) / Double.parseDouble(txvOperaciones.getText().toString());
                    txvOperaciones.setText(String.valueOf(this.resultado));
                    txvSolucion.setText(String.valueOf(this.resultado));
                }
                if(operador.equals("*")){
                    this.resultado = Double.parseDouble(reserva) * Double.parseDouble(txvOperaciones.getText().toString());
                    txvOperaciones.setText(String.valueOf(this.resultado));
                    txvSolucion.setText(String.valueOf(this.resultado));
                }
        }

    }


}