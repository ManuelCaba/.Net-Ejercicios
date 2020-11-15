package es.iesnervion.mcaballero.nbaholder;

import android.app.ListActivity;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
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

        public int getViewTypeCount()
        {

            return 2;
        }

        public int getItemViewType(int position)
        {
            return position%2;
        }

        public int getItemLayout(int position)
        {
            int itemLayout = R.layout.row;

            if (getItemViewType(position) == 1)
            {
                itemLayout = R.layout.inverserow;
            }

            return  itemLayout;
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row = convertView;
            ViewHolder holder;
            TextView txvEquipo;
            ImageView imvLogo;

            if (row == null){
                LayoutInflater inflater = getLayoutInflater();
                row = inflater.inflate(getItemLayout(position), parent, false);

                txvEquipo = (TextView) row.findViewById(R.id.txvEquipo);
                imvLogo = (ImageView) row.findViewById(R.id.imvLogo);
                holder = new ViewHolder (txvEquipo,imvLogo);
                row.setTag(holder);
            }
            else{
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

        public TextView getTxvEquipo (){
            return this.txvEquipo;
        }

        public ImageView getImvLogo (){
            return this.imvLogo;
        }
    }
}
