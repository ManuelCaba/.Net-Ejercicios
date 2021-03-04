package es.iesnervion.mcaballero.examenandroidfinal;

import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProvider;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FragmentInsertProg#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FragmentInsertProg extends Fragment implements View.OnClickListener {

    private EditText etxNombre;
    private EditText etxDNI;
    private Button btnAceptar;
    private ViewModel vm;

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public FragmentInsertProg() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment FragmentInsertProg.
     */
    // TODO: Rename and change types and number of parameters
    public static FragmentInsertProg newInstance(String param1, String param2) {
        FragmentInsertProg fragment = new FragmentInsertProg();
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
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_insert_prog, container, false);

        etxNombre = v.findViewById(R.id.etxNombreProgramador);
        etxDNI = v.findViewById(R.id.etxDNIProgramdor);
        btnAceptar = v.findViewById(R.id.btnAceptarProgramador);
        btnAceptar.setOnClickListener(this);

        return v;
    }

    @Override
    public void onClick(View v) {

        if(v.getId() == R.id.btnAceptarProgramador)
        {
            vm.insertarProgramador(new Programador(etxNombre.getText().toString(), etxDNI.getText().toString()));
            etxNombre.setText("");
            etxDNI.setText("");
        }

    }
}