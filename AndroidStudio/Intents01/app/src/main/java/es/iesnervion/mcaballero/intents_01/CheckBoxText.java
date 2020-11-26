package es.iesnervion.mcaballero.intents_01;

import androidx.appcompat.app.AppCompatActivity;

import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;

public class CheckBoxText extends AppCompatActivity implements CompoundButton.OnCheckedChangeListener
{

    private EditText edtTexto;
    private CheckBox chbNegrita;
    private CheckBox chbGigante;
    private CheckBox chbMinusculo;
    private CheckBox chbRojo;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.checkboxtext);

        edtTexto = findViewById(R.id.edtTexto);
        chbNegrita = findViewById(R.id.chbNegrita);
        chbGigante = findViewById(R.id.chbGigante);
        chbMinusculo = findViewById(R.id.chbMinusculo);
        chbRojo = findViewById(R.id.chbRojo);

        chbNegrita.setOnCheckedChangeListener(this);
        chbGigante.setOnCheckedChangeListener(this);
        chbMinusculo.setOnCheckedChangeListener(this);
        chbRojo.setOnCheckedChangeListener(this);
    }

    @Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked)
    {
        switch(buttonView.getId())
        {
            case(R.id.chbNegrita):

                if(chbNegrita.isChecked())
                {
                    edtTexto.setTypeface(null, Typeface.BOLD);
                }
                else
                {
                    edtTexto.setTypeface(null, Typeface.NORMAL);
                }

                break;
            case(R.id.chbGigante):

                if(chbGigante.isChecked())
                {
                    edtTexto.setTextSize(60);
                    chbMinusculo.setChecked(false);
                }
                else if(!chbMinusculo.isChecked())
                {
                    edtTexto.setTextSize(20);
                }

                break;
            case(R.id.chbMinusculo):

                if(chbMinusculo.isChecked())
                {
                    edtTexto.setTextSize(5);
                    chbGigante.setChecked(false);
                }
                else if(!chbGigante.isChecked())
                {
                    edtTexto.setTextSize(20);
                }

                break;
            case(R.id.chbRojo):

                if(chbRojo.isChecked())
                {
                    edtTexto.setTextColor(Color.parseColor("#ff0000"));
                }
                else
                {
                    edtTexto.setTextColor(Color.parseColor("#ffffff"));
                }

                break;

        }
    }
}