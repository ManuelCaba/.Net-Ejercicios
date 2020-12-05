package com.example.galleryintent;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager.widget.PagerAdapter;
import androidx.viewpager.widget.ViewPager;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Objects;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    ArrayList<Bitmap> imagenes = new ArrayList<Bitmap>();

    public static final int PICK_IMAGE = 1;

    private Button btnInsertar;
    private Button btnEliminar;
    private Button btnGuardar;
    private ViewPager vpgImagenes;
    private EditText nmpCantidad;

    private int limiteImagenes = 5;
    private ViewPagerAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnInsertar = findViewById(R.id.btnInsertar);
        btnEliminar = findViewById(R.id.btnEliminar);
        btnGuardar = findViewById(R.id.btnGuardar);
        nmpCantidad = findViewById(R.id.nmpCantidad);

        btnInsertar.setOnClickListener(this);
        btnEliminar.setOnClickListener(this);
        btnGuardar.setOnClickListener(this);

        vpgImagenes = findViewById(R.id.vpgImagenes);
        adapter = new ViewPagerAdapter(MainActivity.this, imagenes);
        vpgImagenes.setAdapter(adapter);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == PICK_IMAGE) {
            try {
                InputStream inputStream = getContentResolver().openInputStream(data.getData());
                imagenes.add(BitmapFactory.decodeStream(inputStream));
                adapter.setData(imagenes);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onClick(View v) {
        switch(v.getId())
        {
            case R.id.btnInsertar:
                if(limiteImagenes > imagenes.size())
                {
                    Intent intent = new Intent();
                    intent.setType("image/*");
                    intent.setAction(Intent.ACTION_GET_CONTENT);
                    startActivityForResult(Intent.createChooser(intent, "Select Picture"), PICK_IMAGE);
                }
                break;
            case R.id.btnEliminar:
                if(imagenes.size() > 0)
                {
                    imagenes.remove(vpgImagenes.getCurrentItem());
                    adapter.setData(imagenes);
                }
                break;
            case R.id.btnGuardar:
                if(nmpCantidad.getText() != null && imagenes.size() <= Integer.parseInt(nmpCantidad.getText().toString()))
                {
                    limiteImagenes = Integer.parseInt(nmpCantidad.getText().toString());
                }
        }
    }

    class ViewPagerAdapter extends PagerAdapter {

        // Context object
        Context context;

        // Array of images
        ArrayList<Bitmap> arrayImages;

        // Layout Inflater
        LayoutInflater mLayoutInflater;

        // Members
        private boolean mForceReinstantiateItem = false;


        // Viewpager Constructor
        public ViewPagerAdapter(Context context, ArrayList<Bitmap> images) {
            this.context = context;
            this.arrayImages = images;
            mLayoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        }

        @Override
        public int getCount() {
            // return the number of images
            return arrayImages.size();
        }

        @Override
        public boolean isViewFromObject(@NonNull View view, @NonNull Object object) {
            return view == ((LinearLayout) object);
        }

        // This is used to overcome terrible bug that Google isn't fixing
        // We know that getItemPosition() is called right after notifyDataSetChanged()
        // Therefore, the fix is to return POSITION_NONE right after the notifyDataSetChanged() was called - but only once
        @Override
        public int getItemPosition(Object object)
        {
            if (mForceReinstantiateItem)
            {
                mForceReinstantiateItem = false;
                return POSITION_NONE;
            }
            else
            {
                return super.getItemPosition(object);
            }
        }

        public void setData(ArrayList<Bitmap> newContent)
        {
            arrayImages = newContent;
            mForceReinstantiateItem = true;
            notifyDataSetChanged();
        }

        @NonNull
        @Override
        public Object instantiateItem(@NonNull ViewGroup container, final int position) {
            // inflating the item.xml
            View itemView = mLayoutInflater.inflate(R.layout.imagen, container, false);

            // referencing the image view from the item.xml file
            ImageView imageView = (ImageView) itemView.findViewById(R.id.imvImagen);

            // setting the image in the imageView
            imageView.setImageBitmap(arrayImages.get(position));

            // Adding the View
            Objects.requireNonNull(container).addView(itemView);

            return itemView;
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView((LinearLayout) object);
        }
    }
}
