package es.iesnervion.mcaballero.listanbaspinner;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ListActivity;
import android.content.Context;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.Filter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MainActivity extends AppCompatActivity implements TextWatcher, AdapterView.OnItemClickListener, View.OnClickListener {

    AutoCompleteTextView actvEquipo;
    Spinner spnEquipos;
    Button btnAdd;

    private static final ArrayList<Equipo> equipos = new ArrayList<Equipo>(); //Para implementar la interfaz filter se recomienda ArrayList
    ArrayList<String> nombreEquipos = new ArrayList<String>();
    Equipo equipoSeleccionado;

    ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        equipos.add(new Equipo("Boston Celtics", R.drawable.bostonceltics));
        equipos.add(new Equipo("Brooklyn Nets", R.drawable.brooklynnets));
        equipos.add(new Equipo("New York Knicks", R.drawable.newyorkknicks));
        equipos.add(new Equipo("Philadelphia 76ers", R.drawable.philadelphia76ers));
        equipos.add(new Equipo("Toronto Raptors", R.drawable.torontoraptors));
        equipos.add(new Equipo("Golden State Warriors", R.drawable.goldenstatewarriors));
        equipos.add(new Equipo("La Clippers", R.drawable.laclippers));
        equipos.add(new Equipo("Los Angeles Lakers", R.drawable.losangeleslakers));
        equipos.add(new Equipo("Phoenix Suns", R.drawable.phoenixsuns));
        equipos.add(new Equipo("Sacramento Kings", R.drawable.sacramentokings));

        IconicAdapter<Equipo> adaptadorEquipos = new IconicAdapter<Equipo>(this, R.layout.row, R.id.txvEquipo, equipos);

        actvEquipo =  (AutoCompleteTextView)findViewById(R.id.autoCompleteTextView);
        actvEquipo.addTextChangedListener(this);
        actvEquipo.setOnItemClickListener(this);
        actvEquipo.setAdapter(adaptadorEquipos);

        spnEquipos = findViewById(R.id.spnEquipos);
        // Create an ArrayAdapter using the string array and a default spinner layout
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, nombreEquipos);
        // Specify the layout to use when the list of choices appears
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        // Apply the adapter to the spinner
        spnEquipos.setAdapter(adapter);

        btnAdd = findViewById(R.id.btnAdd);
        btnAdd.setOnClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View arg1, int position, long arg3) {
        Object item = parent.getItemAtPosition(position);
        if (item instanceof Equipo){
            equipoSeleccionado = (Equipo) item;
        }
    }

    @Override
    public void onClick(View v) {
        if(equipoSeleccionado != null)
        {
            if(nombreEquipos .size() < 4)
            {
                if(!nombreEquipos.contains(equipoSeleccionado.getEquipo()))
                {
                    nombreEquipos.add(equipoSeleccionado.getEquipo());
                    adapter.notifyDataSetChanged();
                }
            }
        }
    }
    

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {

    }

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {

    }

    @Override
    public void afterTextChanged(Editable s) {

    }


    class IconicAdapter<T> extends ArrayAdapter<T> {

        List<Equipo> items, tempItems, suggestions;

        IconicAdapter(Context c, int resourceId, int textId, ArrayList<Equipo> items)
        {
            super(c, resourceId, textId, (List<T>) items);
            this.items = items;
            tempItems = new ArrayList<Equipo>(items); // this makes the difference.
            suggestions = new ArrayList<Equipo>();
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row=super.getView(position, convertView, parent);

            ImageView logo =(ImageView)row.findViewById(R.id.imvLogo);
            TextView equipo = (TextView) row.findViewById(R.id.txvEquipo);

            logo.setImageResource(items.get(position).getLogo());
            equipo.setText(items.get(position).getEquipo());

            return(row);
        }


        @Override
        public Filter getFilter() {
            return equipoFilter;
        }

        /**
         * Custom Filter implementation for custom suggestions we provide.
         */
        Filter equipoFilter = new Filter() {
            @Override
            public CharSequence convertResultToString(Object resultValue) {
                String str = ((Equipo)resultValue).getEquipo();
                return str;
            }

            @Override
            protected FilterResults performFiltering(CharSequence constraint) {
                if (constraint != null) {
                    suggestions.clear();
                    for (Equipo equipos : tempItems) {
                        if (equipos.getEquipo().toLowerCase().contains(constraint.toString().toLowerCase())) {
                            suggestions.add(equipos);
                        }
                    }
                    FilterResults filterResults = new FilterResults();
                    filterResults.values = suggestions;
                    filterResults.count = suggestions.size();
                    return filterResults;
                } else {
                    return new FilterResults();
                }
            }

            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) {
                ArrayList<Equipo> filterList = (ArrayList<Equipo>) results.values;
                if (results != null && results.count > 0) {
                    items.clear();
                    items.addAll(filterList);
                }
            }
        };
    }
}
