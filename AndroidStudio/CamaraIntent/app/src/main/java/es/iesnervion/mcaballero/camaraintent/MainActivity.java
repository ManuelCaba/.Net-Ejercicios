package es.iesnervion.mcaballero.camaraintent;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.widget.ImageView;

public class MainActivity extends AppCompatActivity {

    private static final int REQUEST_CODE_PHOTO = 1;

    ImageView imvFoto;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        imvFoto = findViewById(R.id.imvFoto);
    }

    @Override
    protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE_PHOTO) {

            Bitmap imageBitmap = (Bitmap) data.getParcelableExtra("data");
            imvFoto.setImageBitmap(imageBitmap);

        }
    }

    public void hacerFoto(View view) {
        Intent photo = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        startActivityForResult(photo,REQUEST_CODE_PHOTO);
    }
}