package es.iesnervion.mcaballero.jan_ken;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import androidx.fragment.app.DialogFragment;

public class EstadisticasDialog extends DialogFragment {

    private TextView txvVictoriasUsuario;
    private TextView txvVictoriasIA;
    private TextView txvEmpates;
    private TextView txvPiedrasUsuario;
    private TextView txvPiedrasIA;
    private TextView txvPapelesUsuario;
    private TextView txvPapelesIA;
    private TextView txvTijerasUsuario;
    private TextView txvTijerasIA;

    private SharedPreferences sharedPreferences;


    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {

        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        // Get the layout inflater
        LayoutInflater inflater = requireActivity().getLayoutInflater();

        View v = inflater.inflate(R.layout.activity_estadisticas, null);

        //Inicialización de los atributos
        txvVictoriasUsuario = v.findViewById(R.id.txvVictoriasUsuario);
        txvVictoriasIA = v.findViewById(R.id.txvVictoriasIA);
        txvEmpates = v.findViewById(R.id.txvEmpates);
        txvPiedrasUsuario = v.findViewById(R.id.txvPiedrasUsuario);
        txvPiedrasIA = v.findViewById(R.id.txvPiedrasIA);
        txvPapelesUsuario = v.findViewById(R.id.txvPapelesUsuario);
        txvPapelesIA = v.findViewById(R.id.txvPapelesIA);
        txvTijerasUsuario = v.findViewById(R.id.txvTijerasUsuario);
        txvTijerasIA = v.findViewById(R.id.txvTijerasIA);

        sharedPreferences = getActivity().getSharedPreferences("EstadisticasPartida", Context.MODE_PRIVATE);

        txvVictoriasUsuario.setText(Integer.toString(sharedPreferences.getInt("Victorias Usuario", 0)));
        txvVictoriasIA.setText(Integer.toString(sharedPreferences.getInt("Victorias IA", 0)));
        txvEmpates.setText(Integer.toString(sharedPreferences.getInt("Empates", 0)));
        txvPiedrasUsuario.setText(Integer.toString(sharedPreferences.getInt("Piedras Usuario", 0)));
        txvPiedrasIA.setText(Integer.toString(sharedPreferences.getInt("Piedras IA", 0)));
        txvPapelesUsuario.setText(Integer.toString(sharedPreferences.getInt("Papeles Usuario", 0)));
        txvPapelesIA.setText(Integer.toString(sharedPreferences.getInt("Papeles IA", 0)));
        txvTijerasUsuario.setText(Integer.toString(sharedPreferences.getInt("Tijeras Usuario", 0)));
        txvTijerasIA.setText(Integer.toString(sharedPreferences.getInt("Tijeras IA", 0)));

        // Inflate and set the layout for the dialog
        // Pass null as the parent view because its going in the dialog layout
        builder.setView(v)
               .setPositiveButton("Volver", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int id) {
                EstadisticasDialog.this.getDialog().cancel();
            }
        });

        return builder.create();
    }
}
