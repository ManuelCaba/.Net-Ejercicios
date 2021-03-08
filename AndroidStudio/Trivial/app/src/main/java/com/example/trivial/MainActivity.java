package com.example.trivial;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.lifecycle.ViewModelStoreOwner;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.RequestBuilder;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private TrivialVM viewModel;
    private LiveData<List<CategoriaConOpciones>> categoriaConOpciones;
    private ImageView ivImagen;
    final Observer<List<CategoriaConOpciones>> observarCategorias = new Observer<List<CategoriaConOpciones>>()
    {
        @Override
        public void onChanged(List<CategoriaConOpciones> listado)
        {
            if(!listado.isEmpty())
            {
                ivImagen = findViewById(R.id.ivFoto);

                Glide.with(getApplicationContext()).load(listado.get(3).getOpciones().get(14).getImagen()).into(ivImagen);
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        viewModel = new ViewModelProvider(this).get(TrivialVM.class);

        categoriaConOpciones = viewModel.getListadoCategoriasConOpciones();
        categoriaConOpciones.observe(this, observarCategorias);
    }
}