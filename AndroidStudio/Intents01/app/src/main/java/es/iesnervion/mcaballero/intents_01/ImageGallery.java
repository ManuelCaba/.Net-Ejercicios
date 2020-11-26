package es.iesnervion.mcaballero.intents_01;

import android.media.Image;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

import androidx.appcompat.app.AppCompatActivity;

public class ImageGallery extends AppCompatActivity {


    private int[] images = {R.drawable.image1, R.drawable.image2, R.drawable.image3, R.drawable.image4, R.drawable.image5};
    private int imagenActual = 0;
    private Button btnAnterior;
    private Button btnSiguiente;
    private ImageView imgView;

    @Override

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.imagegallery);

        btnAnterior = findViewById(R.id.btnAnterior);
        btnSiguiente = findViewById(R.id.btnSiguiente);
        imgView = findViewById(R.id.imgView);
    }

    public void imagenAnterior(View v){

        if(imagenActual == 0)
        {
            imagenActual = images.length - 1;
        }
        else
        {
            imagenActual--;
        }

        imgView.setImageResource(images[imagenActual]);

    }

    public void imagenSiguiente(View v) {

        if(imagenActual == (images.length - 1))
        {
            imagenActual = 0;
        }
        else
        {
            imagenActual++;
        }

        imgView.setImageResource(images[imagenActual]);

    }



}
