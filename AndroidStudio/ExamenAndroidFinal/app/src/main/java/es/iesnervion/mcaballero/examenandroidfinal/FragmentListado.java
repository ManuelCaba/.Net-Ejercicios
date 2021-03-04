package es.iesnervion.mcaballero.examenandroidfinal;

import android.content.Context;
import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FragmentListado#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FragmentListado extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private Spinner spnProgramadores;
    private LiveData<List<Programador>> listadoProgramadores;
    private ViewModel vm;
    private IconicAdapter<Programador> adapter;

    final Observer<List<Programador>> observarProgramadores = new Observer<List<Programador>>()
    {
        @Override
        public void onChanged(List<Programador> listado)
        {
            adapter.setListado((ArrayList<Programador>) listado);
        }
    };

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public FragmentListado() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment FragmentListado.
     */
    // TODO: Rename and change types and number of parameters
    public static FragmentListado newInstance(String param1, String param2) {
        FragmentListado fragment = new FragmentListado();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
        vm = new ViewModelProvider(getActivity()).get(ViewModel.class);
        listadoProgramadores = vm.getProgramadores();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_listado, container, false);
        spnProgramadores = v.findViewById(R.id.spnProgramadores);
        listadoProgramadores = vm.getProgramadores();
        listadoProgramadores.observe(getActivity(), observarProgramadores);
        adapter = new IconicAdapter<Programador>(getActivity(), R.layout.row, new ArrayList<Programador>());
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spnProgramadores.setAdapter(adapter);
        return v;
    }

    //Adaptador ListView
    class IconicAdapter<T> extends ArrayAdapter<T> {

        private ArrayList<Programador> programador;

        IconicAdapter(Context c, int resourceId, ArrayList objects)
        {
            super(c, resourceId, objects);
            programador = objects;
        }
        public void setListado(ArrayList<Programador> listado)
        {
            this.clear();
            this.addAll((T) listado);
            notifyDataSetChanged();
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row = convertView;
            ViewHolderProgramador holder;
            TextView nombre;

            if (row == null){
                LayoutInflater inflater = getLayoutInflater();
                row = inflater.inflate(R.layout.row, parent, false);

                nombre = (TextView) row.findViewById(R.id.rowSpinner);
                holder = new ViewHolderProgramador(nombre);


                row.setTag(holder);
            }
            else{
                holder = (ViewHolderProgramador) row.getTag();
            }

                holder.getNombre().setText(programador.get(position).getNombre());


            return(row);
        }
    }

    //ViewHolder
    class ViewHolderProgramador {
        private TextView nombre;

        public ViewHolderProgramador(TextView nombre) {
            this.nombre = nombre;
        }

        public TextView getNombre() {
            return nombre;
        }
    }
}