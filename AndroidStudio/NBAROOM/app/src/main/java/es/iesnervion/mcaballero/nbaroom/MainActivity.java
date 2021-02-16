package es.iesnervion.mcaballero.nbaroom;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.room.Database;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private NBAVM viewModel;
    private IconicAdapter adapter;
    private ListView list;
    private LiveData<List<NBATeam>> listadoEquipos;
    final Observer<List<NBATeam>> observarListado = new Observer<List<NBATeam>>()
    {
        @Override
        public void onChanged(List<NBATeam> listado)
        {
            adapter.setEquipos((ArrayList<NBATeam>) listado);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        viewModel = new ViewModelProvider(this).get(NBAVM.class);

        listadoEquipos = viewModel.getEquipos();
        listadoEquipos.observe(this, observarListado);

        list = findViewById(R.id.list);
        adapter = new IconicAdapter(this, R.layout.row);
        list.setAdapter(adapter);
    }

    class IconicAdapter<T> extends ArrayAdapter<T> {

        ArrayList<NBATeam> equipos;

        IconicAdapter(Context c, int resourceId)
        {
            super(c, resourceId);
            equipos = new ArrayList<NBATeam>();
        }

        public void setEquipos(ArrayList<NBATeam> equipos)
        {
            this.equipos = equipos;
            notifyDataSetChanged();
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row = convertView;
            ViewHolder holder;
            TextView txvEquipo;
            ImageView imvLogo;

            if (row == null){
                LayoutInflater inflater = getLayoutInflater();
                row = inflater.inflate(R.layout.row, parent, false);

                txvEquipo = (TextView) row.findViewById(R.id.txvEquipo);
                imvLogo = (ImageView) row.findViewById(R.id.imvLogo);
                holder = new ViewHolder (txvEquipo,imvLogo);
                row.setTag(holder);
            }
            else{
                holder = (ViewHolder) row.getTag();
            }

            //holder.getImvLogo().setImageResource(equipos.get(position).getLogo());
            holder.getTxvEquipo().setText(equipos.get(position).getNombre());

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