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
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FragmentListado#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FragmentListado extends Fragment implements AdapterView.OnItemClickListener, AdapterView.OnItemSelectedListener {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private Spinner spnProgramadores;
    private ListView lvBugs;
    private List<Bug> listadoBugsProgramador;
    private LiveData<List<ProgramadorConBugs>> listadoProgramadoresConBugs;
    private ViewModel vm;
    private ArrayAdapter<ProgramadorConBugs> programadoresAdapter;
    private IconicAdapter<Bug> bugsadapter;

    final Observer<List<ProgramadorConBugs>> observarProgramadoresConBugs = new Observer<List<ProgramadorConBugs>>()
    {
        @Override
        public void onChanged(List<ProgramadorConBugs> listado)
        {
            programadoresAdapter.clear();
            programadoresAdapter.addAll(listado);
            programadoresAdapter.notifyDataSetChanged();

            if(listadoBugsProgramador != null)
            {
                bugsadapter.setListado((ArrayList<Bug>) listado.get(vm.getPosicionProgramadorSeleccionado()).getBugs());
            }
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
        listadoProgramadoresConBugs = vm.getProgramadoresConBugs();
        listadoProgramadoresConBugs.observe(getActivity(), observarProgramadoresConBugs);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_listado, container, false);
        spnProgramadores = v.findViewById(R.id.spnProgramadores);
        //adapter = new IconicAdapter<Programador>(getActivity(), R.layout.row, new ArrayList<Programador>());
        programadoresAdapter = new ArrayAdapter<ProgramadorConBugs>(getActivity(), android.R.layout.simple_spinner_dropdown_item, new ArrayList<ProgramadorConBugs>());
        programadoresAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spnProgramadores.setAdapter(programadoresAdapter);
        spnProgramadores.setOnItemSelectedListener(this);

        lvBugs = v.findViewById(R.id.lvwBugsProgramador);
        bugsadapter = new IconicAdapter<Bug>(getActivity(), R.layout.row, new ArrayList<Bug>());
        lvBugs.setAdapter(bugsadapter);

        return v;
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
        listadoBugsProgramador = listadoProgramadoresConBugs.getValue().get(position).getBugs();

        bugsadapter.setListado((ArrayList<Bug>) listadoBugsProgramador);
        bugsadapter.notifyDataSetChanged();

        vm.setPosicionProgramadorSeleccionado(position);
    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    //Adaptador ListView
    class IconicAdapter<T> extends ArrayAdapter<T> {

        private ArrayList<Bug> bugs;

        IconicAdapter(Context c, int resourceId, ArrayList objects)
        {
            super(c, resourceId, objects);
            bugs = objects;
        }
        public void setListado(ArrayList<Bug> listado)
        {
            this.bugs.clear();
            this.bugs.addAll(listado);
            notifyDataSetChanged();
        }

        public View getView(int position, View convertView, ViewGroup parent)
        {
            View row = convertView;
            ViewHolderBug holder;
            TextView ID;
            TextView prioridad;

            if (row == null){
                LayoutInflater inflater = getLayoutInflater();
                row = inflater.inflate(R.layout.row, parent, false);

                ID = (TextView) row.findViewById(R.id.IDBugRow);
                prioridad = (TextView) row.findViewById(R.id.PrioridadBugRow);
                holder = new ViewHolderBug(ID, prioridad);


                row.setTag(holder);
            }
            else{
                holder = (ViewHolderBug) row.getTag();
            }

            holder.getID().setText(Integer.toString(bugs.get(position).getID()));
            holder.getPrioridad().setText(bugs.get(position).getPrioridad().name());


            return(row);
        }
    }

    //ViewHolder
    class ViewHolderBug {
        private TextView ID;
        private TextView prioridad;

        public ViewHolderBug(TextView ID, TextView prioridad) {
            this.ID = ID;
            this.prioridad = prioridad;
        }

        public TextView getID() {
            return ID;
        }

        public TextView getPrioridad() {
            return prioridad;
        }
    }
}