package com.example.examenandroid;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener, AdapterView.OnItemClickListener, RadioGroup.OnCheckedChangeListener {

    private ArrayList<String> filtroSpinner;
    private ArrayList<Object> listaJuegosDesarrolladores;
    private ArrayList<Object> listaAux;
    private boolean esDetalle;

    //Elementos Layout
    private Spinner spinner;
    private ListView lista;
    private RadioGroup radioGroup;

    //Adaptadores
    ArrayAdapter<String> spinnerAdapter;
    IconicAdapter<Object> listAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        esDetalle = true;

        //Spinner

        //Cargar array
        filtroSpinner = new ArrayList<String>();
        filtroSpinner.add("Todos");
        filtroSpinner.add("Desarrolladores");

        //Enlazar elemento layout
        spinner = findViewById(R.id.spinner);

        //Crear adaptador
        spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, filtroSpinner);
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        //Asignar adaptador a spinner
        spinner.setAdapter(spinnerAdapter);

        //Cambiar listener de spinner
        spinner.setOnItemSelectedListener(this);

        //ListView

        //Cargar array
        Datos objDatos = (Datos) getApplication();
        listaAux  = objDatos.getListaEjemplo();
        listaJuegosDesarrolladores = new ArrayList<Object>(listaAux);

        //Enlazar elemento layout
        lista = findViewById(R.id.lista);

        //Crear adaptador
        listAdapter = new IconicAdapter<Object>(this, R.layout.fila_desarrollador, listaJuegosDesarrolladores);

        //Asignar adaptador a lista
        lista.setAdapter(listAdapter);

        //Cambiar listener de la lista
        lista.setOnItemClickListener(this);

        //Radio group
        radioGroup = findViewById(R.id.radiogroup);
        radioGroup.setOnCheckedChangeListener(this);
    }


    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        Object item = parent.getItemAtPosition(position);

        String opcion = item.toString();

        if(opcion.equals("Desarrolladores"))
        {
            for(Object elemento : listaAux)
            {
                if(elemento instanceof Desarrollador)
                {
                    listAdapter.remove(elemento);

                    listAdapter.notifyDataSetChanged();
                }
            }
        }
        else
        {
            listAdapter.clear();
            listAdapter.addAll(listaAux);
            listAdapter.notifyDataSetChanged();
        }


    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Object item = parent.getItemAtPosition(position);

        if(esDetalle)
        {
            if(item instanceof Desarrollador)
            {
                Intent intent = new Intent(MainActivity.this, DetallesDesarrollador.class);
                intent.putExtra("result", (Desarrollador) item);
                startActivity(intent);
            }
            else
            {
                Intent intent = new Intent(MainActivity.this, DetallesJuego.class);
                intent.putExtra("result", (Juego) item);
                startActivity(intent);
            }

        }
        else
        {
            listaJuegosDesarrolladores.remove(item);
            listaAux.remove(item);
            listAdapter.notifyDataSetChanged();
        }
    }

    @Override
    public void onCheckedChanged(RadioGroup group, int checkedId) {

        esDetalle = false;

        if(checkedId == R.id.detalle)
        {
            esDetalle = true;
        }
    }


    //Adaptador ListView
    class IconicAdapter<T> extends ArrayAdapter<T> {

        IconicAdapter(Context c, int resourceId, ArrayList objects)
        {
            super(c, resourceId, objects);
        }

        public int getViewTypeCount()
        {

            return 2;
        }

        public int getItemViewType(int position)
        {
            int positionView = 0;

            if(listaJuegosDesarrolladores.get(position) instanceof Juego)
            {
                positionView = 1;
            }
            return positionView;
        }

        public int getItemLayout(int position)
        {
            int itemLayout = R.layout.fila_desarrollador;

            if (getItemViewType(position) == 1)
            {
                itemLayout = R.layout.fila_juego;
            }

            return  itemLayout;
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row = convertView;
            Object holder;
            TextView nombre;
            TextView year;
            ImageView logo;

            if (row == null){
                LayoutInflater inflater = getLayoutInflater();
                row = inflater.inflate(getItemLayout(position), parent, false);

                if(getItemViewType(position) == 0)
                {
                    nombre = (TextView) row.findViewById(R.id.nombreDes);
                    year = (TextView) row.findViewById(R.id.yearDes);
                    logo = (ImageView) row.findViewById(R.id.logoDes);
                    holder = new ViewHolderDesarrollador(nombre, year, logo);
                }
                else
                {
                    nombre = (TextView) row.findViewById(R.id.nombreJue);
                    holder = new ViewHolderJuego(nombre);
                }

                row.setTag(holder);
            }
            else{
                holder = (Object) row.getTag();
            }

            if(getItemViewType(position) == 0)
            {
                ((ViewHolderDesarrollador) holder).getNombre().setText(((Desarrollador)listaJuegosDesarrolladores.get(position)).getNombre());
                ((ViewHolderDesarrollador) holder).getYear().setText(Integer.toString(((Desarrollador)listaJuegosDesarrolladores.get(position)).getAnhoFundacion()));
                ((ViewHolderDesarrollador) holder).getLogo().setImageResource(((Desarrollador)listaJuegosDesarrolladores.get(position)).getLogo());
            }
            else
            {
                ((ViewHolderJuego) holder).getNombre().setText(((Juego)listaJuegosDesarrolladores.get(position)).getNombre());
            }

            return(row);
        }
    }

    //ViewHolder
    class ViewHolderDesarrollador {
        private TextView nombre;
        private TextView year;
        private ImageView logo;

        public ViewHolderDesarrollador(TextView nombre, TextView year, ImageView logo) {
            this.nombre = nombre;
            this.year = year;
            this.logo = logo;
        }

        public TextView getNombre() {
            return nombre;
        }

        public TextView getYear() {
            return year;
        }

        public ImageView getLogo() {
            return logo;
        }
    }

    class ViewHolderJuego {
        private TextView nombre;
        private TextView year;
        private ImageView logo;

        public ViewHolderJuego(TextView nombre) {
            this.nombre = nombre;
        }

        public TextView getNombre() {
            return nombre;
        }
    }
}