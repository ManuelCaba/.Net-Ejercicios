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
import android.widget.Filter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MainActivity extends AppCompatActivity implements TextWatcher {

    AutoCompleteTextView actvEquipo;

    private static final List<Equipo> equipos= Arrays.asList(new Equipo[]{new Equipo("Boston Celtics", R.drawable.bostonceltics),
            new Equipo("Brooklyn Nets", R.drawable.brooklynnets),
            new Equipo("New York Knicks", R.drawable.newyorkknicks),
            new Equipo("Philadelphia 76ers", R.drawable.philadelphia76ers),
            new Equipo("Toronto Raptors", R.drawable.torontoraptors),
            new Equipo("Golden State Warriors", R.drawable.goldenstatewarriors),
            new Equipo("La Clippers", R.drawable.laclippers),
            new Equipo("Los Angeles Lakers", R.drawable.losangeleslakers),
            new Equipo("Phoenix Suns", R.drawable.phoenixsuns),
            new Equipo("Sacramento Kings", R.drawable.sacramentokings)});

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        IconicAdapter<Equipo> adaptadorEquipos = new IconicAdapter<Equipo>(this, R.layout.row, R.id.txvEquipo, equipos);
        actvEquipo =  (AutoCompleteTextView)findViewById(R.id.autoCompleteTextView);
        actvEquipo.addTextChangedListener(this);
        actvEquipo.setAdapter(adaptadorEquipos);
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

        IconicAdapter(Context c, int resourceId, int textId, List<Equipo> items)
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

            logo.setImageResource(equipos.get(position).getLogo());
            equipo.setText(equipos.get(position).getEquipo());

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
                List<Equipo> filterList = (ArrayList<Equipo>) results.values;
                if (results != null && results.count > 0) {
                    clear();
                    for (Equipo equipo : filterList) {
                        add((T) equipo);
                        notifyDataSetChanged();
                    }
                }
            }
        };
    }
}
