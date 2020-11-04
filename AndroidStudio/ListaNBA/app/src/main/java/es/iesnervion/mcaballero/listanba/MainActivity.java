package es.iesnervion.mcaballero.listanba;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ListActivity;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class MainActivity extends ListActivity {

    TextView selection;
    private static final Equipo[] equipos={new Equipo("Boston Celtics", R.drawable.bostonceltics),
            new Equipo("Brooklyn Nets", R.drawable.brooklynnets),
            new Equipo("New York Knicks", R.drawable.newyorkknicks),
            new Equipo("Philadelphia 76ers", R.drawable.philadelphia76ers),
            new Equipo("Toronto Raptors", R.drawable.torontoraptors),
            new Equipo("Golden State Warriors", R.drawable.goldenstatewarriors),
            new Equipo("La Clippers", R.drawable.laclippers),
            new Equipo("Los Angeles Lakers", R.drawable.losangeleslakers),
            new Equipo("Phoenix Suns", R.drawable.phoenixsuns),
            new Equipo("Sacramento Kings", R.drawable.sacramentokings)};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setListAdapter(new IconicAdapter<Equipo>(this, R.layout.row, R.id.txvEquipo, equipos));
        selection=(TextView)findViewById(R.id.selection);
    }

    public void onListItemClick(ListView parent, View v, int position, long id) {
        selection.setText(equipos[position].getEquipo());
    }

    class IconicAdapter<T> extends ArrayAdapter<T> {

        IconicAdapter(Context c, int resourceId, int textId, T[] objects)
        {
            super(c, resourceId, textId, objects);
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row=super.getView(position, convertView, parent);

            ImageView logo =(ImageView)row.findViewById(R.id.imvLogo);
            TextView equipo = (TextView) row.findViewById(R.id.txvEquipo);

            logo.setImageResource(equipos[position].getLogo());
            equipo.setText(equipos[position].getEquipo());

            return(row);
        }
    }
}
