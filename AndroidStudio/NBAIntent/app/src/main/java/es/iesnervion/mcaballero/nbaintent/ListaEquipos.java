package es.iesnervion.mcaballero.nbaintent;

import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class ListaEquipos extends ListActivity {

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
        setContentView(R.layout.activity_lista_equipos);
        setListAdapter(new IconicAdapter<Equipo>(this, R.layout.row, equipos));
    }

    public void onListItemClick(ListView parent, View v, int position, long id) {
        Intent returnIntent = new Intent();
        returnIntent.putExtra("result", equipos[position]);
        setResult(Activity.RESULT_OK,returnIntent);
        finish();
    }

    class IconicAdapter<T> extends ArrayAdapter<T> {

        IconicAdapter(Context c, int resourceId, T[] objects)
        {
            super(c, resourceId, objects);
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row = convertView;
            ViewHolder holder;
            TextView txvEquipo;
            ImageView imvLogo;

            if(row == null)
            {
                LayoutInflater inflater = getLayoutInflater();
                row = inflater.inflate(R.layout.row, parent, false);

                txvEquipo = row.findViewById(R.id.txvEquipo);
                imvLogo = row.findViewById(R.id.imvLogo);

                holder = new ViewHolder(txvEquipo, imvLogo);
                row.setTag(holder);
            }
            else
            {
                holder = (ViewHolder) row.getTag();
            }

            holder.getImvLogo().setImageResource(equipos[position].getLogo());
            holder.getTxvEquipo().setText(equipos[position].getEquipo());

            return(row);
        }
    }

    class ViewHolder {
        private TextView txvEquipo;
        private ImageView imvLogo;

        ViewHolder (TextView txvEquipo, ImageView imvLogo){
            this.txvEquipo = txvEquipo;
            this.imvLogo = imvLogo;
        }

        public TextView getTxvEquipo(){
            return this.txvEquipo;
        }

        public ImageView getImvLogo(){
            return this.imvLogo;
        }
    }
}