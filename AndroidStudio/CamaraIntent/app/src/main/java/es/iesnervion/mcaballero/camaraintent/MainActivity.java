package es.iesnervion.mcaballero.camaraintent;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    private static final int REQUEST_CODE_PHOTO = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void hacerFoto(View view) {
        Intent photo = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        startActivityForResult(photo,REQUEST_CODE_PHOTO);
    }
}