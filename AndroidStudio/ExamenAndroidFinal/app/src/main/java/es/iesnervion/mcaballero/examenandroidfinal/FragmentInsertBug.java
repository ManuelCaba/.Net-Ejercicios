package es.iesnervion.mcaballero.examenandroidfinal;

import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProvider;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FragmentInsertBug#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FragmentInsertBug extends Fragment implements View.OnClickListener, RadioGroup.OnCheckedChangeListener {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private RadioGroup rdgPrioridades;
    private EditText etxDNIProgramador;
    private Button btnAceptar;
    private Bug bug;
    private ViewModel vm;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public FragmentInsertBug() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment FragmentInsertBug.
     */
    // TODO: Rename and change types and number of parameters
    public static FragmentInsertBug newInstance(String param1, String param2) {
        FragmentInsertBug fragment = new FragmentInsertBug();
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
        bug = new Bug(0,Prioridad.BAJA, "");
        vm = new ViewModelProvider(getActivity()).get(ViewModel.class);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_insert_bug, container, false);
        rdgPrioridades = v.findViewById(R.id.rdgPrioridades);
        rdgPrioridades.setOnCheckedChangeListener(this);
        etxDNIProgramador = v.findViewById(R.id.etxDNIProgramdorBug);
        btnAceptar = v.findViewById(R.id.btnAceptarBug);
        btnAceptar.setOnClickListener(this);
        return v;
    }

    @Override
    public void onClick(View v) {
        if(v.getId() == R.id.btnAceptarBug)
        {
            bug.setIDProgramador(etxDNIProgramador.getText().toString());
            etxDNIProgramador.setText("");
            vm.insertarBug(bug);
        }
    }

    @Override
    public void onCheckedChanged(RadioGroup group, int checkedId) {
        if(checkedId == R.id.rdbAlta)
        {
            bug.setPrioridad(Prioridad.ALTA);
        }
        else {
            bug.setPrioridad(Prioridad.BAJA);
        }
    }
}