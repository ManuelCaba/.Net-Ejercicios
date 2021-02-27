package com.example.trivial;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.sqlite.db.SupportSQLiteDatabase;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Executors;

@Database(entities = {Categoria.class, Opcion.class}, version = 1)
public abstract class TrivialDataBase extends RoomDatabase {
    public abstract CategoriaDAO categoriaDAO();
    public abstract OpcionDAO opcionDAO();

    private static TrivialDataBase INSTANCE;

    static TrivialDataBase getDatabase(final Context context)
    {
        if(INSTANCE == null)
        {
            synchronized (TrivialDataBase.class)
            {
                if(INSTANCE == null)
                {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), TrivialDataBase.class, "TrivialDataBase.db")
                            .addCallback(new Callback() {
                                @Override
                                public void onCreate(@NonNull SupportSQLiteDatabase db) {



                                    //Poblar Categorias
                                    ArrayList<Categoria> categorias = new ArrayList<Categoria>();
                                    categorias.add(new Categoria("Actores"));
                                    categorias.add(new Categoria("Pokemon"));
                                    categorias.add(new Categoria("Super Heroes"));
                                    categorias.add(new Categoria("Disney"));
                                    categorias.add(new Categoria("League of Legends"));

                                    String insertarCategoria = "INSERT INTO Categorias(Categoria) VALUES ";

                                    for(Categoria categoria : categorias)
                                    {
                                        insertarCategoria+="('"+categoria.getCategoria()+"'),";
                                    }

                                    insertarCategoria = insertarCategoria.substring(0, insertarCategoria.length() - 1);

                                    //db.execSQL(insertarCategoria);
                                    Executors.newSingleThreadExecutor().execute(()->INSTANCE.categoriaDAO().insertarListado(categorias));



                                    //Poblar Opciones
                                    ArrayList<Opcion> opciones = new ArrayList<Opcion>();

                                    //Categoria Actores
                                    opciones.add(new Opcion("Chris Evans", "https://drive.google.com/uc?id=1rV2DA8eUCP3Gj72sJ4ez0tjIh0Ijth1h",1));
                                    opciones.add(new Opcion("Robert Downey Jr.", "https://drive.google.com/uc?id=1RdTwaVG_w8ai7I4nNSKErNcinJF07rU9",1));
                                    opciones.add(new Opcion("Hugh Jackman", "https://drive.google.com/uc?id=1Zf4SKZXLnksq0q4O0zv5Mx9ji4a3lRbJ",1));
                                    opciones.add(new Opcion("James McAvoy", "https://drive.google.com/uc?id=1Zf4SKZXLnksq0q4O0zv5Mx9ji4a3lRbJ",1));
                                    opciones.add(new Opcion("Matt Damon", "https://drive.google.com/uc?id=1QdG90wyzSe9EyXHrc3_lBs9Oy-rkqFXY",1));
                                    opciones.add(new Opcion("Dwayne Johnson", "https://drive.google.com/uc?id=1QdG90wyzSe9EyXHrc3_lBs9Oy-rkqFXY",1));
                                    opciones.add(new Opcion("Chris Hemsworth", "https://drive.google.com/uc?id=1PaY5p3ZcVbWsKeMX6mkZJZI-r0EEYSkT",1));
                                    opciones.add(new Opcion("Tom Cruise", "https://drive.google.com/uc?id=19mYQXf8lHbJ3FqjAqa3gBO-DPWkUJ2e3",1));
                                    opciones.add(new Opcion("Pierce Brosnan", "https://drive.google.com/uc?id=1EHbIfhd8CMi3GN3fNsy2EuhjKehOi0nr",1));
                                    opciones.add(new Opcion("Patrick Stewart", "https://drive.google.com/uc?id=1ufzWEOA2jH_IJd9sxQxBc8Rk0XnD9PqL",1));
                                    opciones.add(new Opcion("Michael Fassbender", "https://drive.google.com/uc?id=1LZeLuoTafjK9D_APP8RowN2MbcuTnNsT",1));
                                    opciones.add(new Opcion("Will Smith", "https://drive.google.com/uc?id=1XKx0Q206aBAFzAijuX2EJ5pUD3akYSgO",1));
                                    opciones.add(new Opcion("Jason Statham", "https://drive.google.com/uc?id=16E63UZz-vjJPn1IwApKmX8Jcc_oWUscL",1));
                                    opciones.add(new Opcion("Vin Diesel", "https://drive.google.com/uc?id=1vFb9Z9pQYT57VCdzRewQmT4jNWDjjy1s",1));
                                    opciones.add(new Opcion("Ryan Reynolds", "https://drive.google.com/uc?id=1ISCUD6kP4-h1h0Y4RTI3qPcG4esxhKhh",1));
                                    opciones.add(new Opcion("Ben Affleck", "https://drive.google.com/uc?id=1CUmDvAFAyEdHmhtqTyksfkHb_fZbGof2",1));
                                    opciones.add(new Opcion("Ian McKellen", "https://drive.google.com/uc?id=1oGS6SPv6EXbzTuFm7NG6zH2Sknf_BbbF",1));
                                    opciones.add(new Opcion("Keanu Reeves", "https://drive.google.com/uc?id=1iS0xa-a8m6Qf1CHA09FpeWQUDkRLYPSx",1));
                                    opciones.add(new Opcion("Morgan Freeman", "https://drive.google.com/uc?id=1JbzfnGzaiqVlsDN6Fb2zJNMoAFM5HeTs",1));
                                    opciones.add(new Opcion("George Clooney", "https://drive.google.com/uc?id=1YKfL0wMkx9_gVAyRfXMneuSqMNJ2bPRL",1));

                                    //Categoria Pokemon
                                    opciones.add(new Opcion("Pikachu", "https://drive.google.com/uc?id=1k1YTUAp_9KPu3Pf7woRoWdUzixSeoB8H",2));
                                    opciones.add(new Opcion("Aromatisse", "https://drive.google.com/uc?id=1hq7hoPqqnw2T_97iadA7cAFr55iXNM5C",2));
                                    opciones.add(new Opcion("Blitzle", "https://drive.google.com/uc?id=1vrUwA8xSlgbx2aplw56alxJmPahWkqE0",2));
                                    opciones.add(new Opcion("Dragonite", "https://drive.google.com/uc?id=15L1ftQrS95UTxGnVM5BRrccg7rhUIjQa",2));
                                    opciones.add(new Opcion("Electivire", "https://drive.google.com/uc?id=1KPaFpaOSDqC1EBZ6l9fm7RoGv0uinmCT",2));
                                    opciones.add(new Opcion("Galvantula", "https://drive.google.com/uc?id=1HSoIrqESdT3jxZHMnPeVRKLurcvVztgD",2));
                                    opciones.add(new Opcion("Litleo", "https://drive.google.com/uc?id=1QFH9LZdZetmB9UjVqrE5Sa7D9BFCEotF",2));
                                    opciones.add(new Opcion("Metapod", "https://drive.google.com/uc?id=1kvBXQD9Ebrf1sCRwUlhP4HhRe2dTcRSi",2));
                                    opciones.add(new Opcion("Milotic", "https://drive.google.com/uc?id=1mBvekg_TqjAKzC3TXt7QOgjUEhWEtjm5",2));
                                    opciones.add(new Opcion("Misdreavus", "https://drive.google.com/uc?id=1lh5r5pHedAxgQ-rRgloHI8FL23-lVhhf",2));
                                    opciones.add(new Opcion("Pachirisu", "https://drive.google.com/uc?id=1v4ytNdNmPLZvN8CcJQu2Vv85boPtJ4E8",2));
                                    opciones.add(new Opcion("Psyduck", "https://drive.google.com/uc?id=1TDZAc26oIpZtidIDqq8FJqwdQtIf8yj-",2));
                                    opciones.add(new Opcion("Runerigus", "https://drive.google.com/uc?id=17YlkDSdRGGD31gVGyRNNLz3yJOsCzB1i",2));
                                    opciones.add(new Opcion("Sandslash", "https://drive.google.com/uc?id=1NsE7Hgs5C3jSIHs4v5zAXYnZnAySSqcn",2));
                                    opciones.add(new Opcion("Snorlax", "https://drive.google.com/uc?id=1B87o-Xj_Aob_11lqElgrH39RKcbYFbn8",2));
                                    opciones.add(new Opcion("Togepi", "https://drive.google.com/uc?id=1jH-1ttMzEcihD19jepVJ0GFAbfKUPxl9",2));
                                    opciones.add(new Opcion("Torracat", "https://drive.google.com/uc?id=1VUzhaymr9JnyUl_br-Qq6B5exRFdf91-",2));
                                    opciones.add(new Opcion("Turtwig", "https://drive.google.com/uc?id=1i_4kRk5JTRAVEjNdV3BhjYEahO2au1Jf",2));
                                    opciones.add(new Opcion("Weezing", "https://drive.google.com/uc?id=1T_tZh--0wkMkNifUZZ4-yvfHANsmdarK",2));
                                    opciones.add(new Opcion("Zekrom", "https://drive.google.com/uc?id=1mUNlLXTDWc1U3pdFOnEZJq_UEUuz3cGW",2));

                                    String insertarOpcion = "INSERT INTO Opciones(Nombre, Imagen, IDCategoria) VALUES ";

                                    for(Opcion opcion : opciones)
                                    {
                                        insertarOpcion+="('"+opcion.getNombre()+"','"+opcion.getImagen()+"',"+opcion.getIDCategoria()+"),";
                                    }

                                    insertarOpcion = insertarOpcion.substring(0, insertarOpcion.length() - 1);

                                    System.out.println(insertarOpcion);

                                    //db.execSQL(insertarOpcion);
                                    Executors.newSingleThreadExecutor().execute(()->INSTANCE.opcionDAO().insertarListado(opciones));




                                }
                            }).build();
                }
            }
        }

        return INSTANCE;
    }
}
