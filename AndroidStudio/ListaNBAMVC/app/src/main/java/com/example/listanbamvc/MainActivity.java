package com.example.listanbamvc;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements AdapterView.OnItemClickListener {

    TextView selection;
    ListView lvwLista;
    EditText edtEquipo;
    private static ArrayList<Equipo> equipos;
    NBAVM mViewModel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        mViewModel = new ViewModelProvider(this).get(NBAVM.class);
        equipos = mViewModel.getEquipos().getValue();

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        lvwLista = findViewById(R.id.list);
        selection=(TextView)findViewById(R.id.selection);
        edtEquipo= findViewById(R.id.edtEquipo);

        lvwLista.setAdapter(new IconicAdapter<Equipo>(this, R.layout.row, equipos));
        lvwLista.setOnItemClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        selection.setText(equipos.get(position).getEquipo());
    }

    public void addEquipo(View v)
    {
        String ejemplo = edtEquipo.getText().toString();

        if(!edtEquipo.getText().toString().matches(""))
        {
           mViewModel.getEquipos().getValue().add(new Equipo(edtEquipo.getText().toString(), 0));
        }
    }

    class IconicAdapter<T> extends ArrayAdapter<T> {

        IconicAdapter(Context c, int resourceId, ArrayList objects)
        {
            super(c, resourceId, objects);
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

            holder.getImvLogo().setImageResource(equipos.get(position).getLogo());
            holder.getTxvEquipo().setText(equipos.get(position).getEquipo());

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