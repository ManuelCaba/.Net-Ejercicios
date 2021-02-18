package es.iesnervion.mcaballero.nbaroom;

import android.content.Context;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ListFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ListFragment extends Fragment {

    private NBAVM viewModel;
    private IconicAdapter adapter;
    private ListView list;
    private LiveData<List<NBATeam>> listadoEquipos;
    final Observer<List<NBATeam>> observarListado = new Observer<List<NBATeam>>()
    {
        @Override
        public void onChanged(List<NBATeam> listado)
        {
            adapter.setEquipos((ArrayList) listado);
        }
    };

    public ListFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ListFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static ListFragment newInstance(String param1, String param2) {
        ListFragment fragment = new ListFragment();
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        viewModel = new ViewModelProvider(getActivity()).get(NBAVM.class);

        listadoEquipos = viewModel.getEquipos();
        listadoEquipos.observe(this, observarListado);

        adapter = new IconicAdapter(getActivity(), R.layout.row, new ArrayList <NBATeam>());

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_list, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        list = view.findViewById(R.id.list);
        list.setAdapter(adapter);
    }

    class IconicAdapter<T> extends ArrayAdapter<T> {

        ArrayList<NBATeam> equipos;

        IconicAdapter(Context c, int resourceId, ArrayList equipos)
        {
            super(c, resourceId, equipos);
            this.equipos = equipos;
        }

        public void setEquipos(ArrayList equipos)
        {
            this.equipos.clear();
            this.equipos.addAll(equipos);
            this.notifyDataSetChanged();
        }

        @Override
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