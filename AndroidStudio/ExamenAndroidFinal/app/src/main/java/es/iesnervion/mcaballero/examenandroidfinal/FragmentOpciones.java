package es.iesnervion.mcaballero.examenandroidfinal;

import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProvider;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FragmentOpciones#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FragmentOpciones extends Fragment implements View.OnClickListener {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private Button btnProgramador;
    private Button btnBug;
    private ViewModel vm;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public FragmentOpciones() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment FragmentOpciones.
     */
    // TODO: Rename and change types and number of parameters
    public static FragmentOpciones newInstance(String param1, String param2) {
        FragmentOpciones fragment = new FragmentOpciones();
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
        View v = inflater.inflate(R.layout.fragment_opciones, container, false);
        btnProgramador = v.findViewById(R.id.btnProgramador);
        btnBug = v.findViewById(R.id.btnBug);
        btnProgramador.setOnClickListener(this);
        btnBug.setOnClickListener(this);
        return v;
    }

    @Override
    public void onClick(View v) {
        if(v.getId() == R.id.btnProgramador)
        {
            vm.setOpcion(0);
        }
        else
        {
            vm.setOpcion(1);
        }
    }
}