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

                                    //Categoria Super Héroes
                                    opciones.add(new Opcion("Ciclope", "https://drive.google.com/uc?id=1sIQcccbFqMg_XmTzhGf8oovwFlz8WGL7",3));
                                    opciones.add(new Opcion("Cyborg", "https://drive.google.com/uc?id=1fR9u22HB2wpEUQeqYfPhmrsmoSrcFwst",3));
                                    opciones.add(new Opcion("Dr.Manhattan", "https://drive.google.com/uc?id=1M6FdCVCNTlXGSlFbSme8SjILFei7ybM6",3));
                                    opciones.add(new Opcion("Dr.Strange", "https://drive.google.com/uc?id=13qtZBpliRATYo5jSCzPgh7emAzSw5jum",3));
                                    opciones.add(new Opcion("Flash", "https://drive.google.com/uc?id=1AWdycI4M4ccowEAZL4mCd-FWnqu4tgEQ",3));
                                    opciones.add(new Opcion("Ghost Rider", "https://drive.google.com/uc?id=1fchUQjKmUK4CCQUJ4eEyUHeuYg16DkHt",3));
                                    opciones.add(new Opcion("Green Arrow", "https://drive.google.com/uc?id=1SLkBykzTQu8Zq_1vDEuosPf1-jzTeBLn",3));
                                    opciones.add(new Opcion("Harley Queen", "https://drive.google.com/uc?id=1CLADe5LCLf7QPWvk4yzelGdNZIRed4u8",3));
                                    opciones.add(new Opcion("Luke Cage", "https://drive.google.com/uc?id=1OsfSlE_WdeuuAgiZefJpO5d8hUdlrc2G",3));
                                    opciones.add(new Opcion("War Machine", "https://drive.google.com/uc?id=1qc32MkUVvtIkHayUy1mpkAIWGQzCrwS9",3));
                                    opciones.add(new Opcion("Optimus Prime", "https://drive.google.com/uc?id=1D7lG17CV3SvWTi54f_HH93BQCoNzWaHD",3));
                                    opciones.add(new Opcion("Punisher", "https://drive.google.com/uc?id=1TyLcy8ffHM5OMkWSewsZETPPLFqutFH4",3));
                                    opciones.add(new Opcion("Rayo Negro", "https://drive.google.com/uc?id=1naSMzCGhpf0nze4p8Hc-v4S2yAQoTbD6",3));
                                    opciones.add(new Opcion("Robin", "https://drive.google.com/uc?id=1MBY6h8QFsi-uaJnNva53ANcopwHr7K7f",3));
                                    opciones.add(new Opcion("Rorschach", "https://drive.google.com/uc?id=1Rj8f15g8PH84K7AtLnSqZn8f20cd5zH3",3));
                                    opciones.add(new Opcion("Silver Surfer", "https://drive.google.com/uc?id=1pG_ZtBTTG4TZjpUOOgxdhHYkLjta2vd7",3));
                                    opciones.add(new Opcion("Supergirl", "https://drive.google.com/uc?id=1JOcdVtdgEVtzQ0U-v_M3naj0j6LR17vl",3));
                                    opciones.add(new Opcion("Tormenta", "https://drive.google.com/uc?id=1AXr2Qj5xJIbNIpLjXCiwNZo9q4GkgQdT",3));
                                    opciones.add(new Opcion("Venom", "https://drive.google.com/uc?id=1SBtGxLNTtmPG9ajOahZfCvEeDaNTT5HQ",3));
                                    opciones.add(new Opcion("Vision", "https://drive.google.com/uc?id=1kCWCE_nPNMJ5bIhpjdo5uKphBegCTAiQ",3));

                                    //Categoria Disney
                                    opciones.add(new Opcion("Ariel", "https://drive.google.com/uc?id=126vnfpdYmDNWK3GkVAHzAqfoAEbe2Z2W",4));
                                    opciones.add(new Opcion("Bagheera", "https://drive.google.com/uc?id=1KH2xdpfL06ah9mP3n3XkjZ_ExlW9jyCJ",4));
                                    opciones.add(new Opcion("Clopi Trouillefou", "https://drive.google.com/uc?id=1iO5kMYghKDMMNyW2w_alQkCgthm92Byu",4));
                                    opciones.add(new Opcion("Flor", "https://drive.google.com/uc?id=1bU7iQRYR8QfFImm-Tc7tvbORSOo0kyWr",4));
                                    opciones.add(new Opcion("Gus Gus", "https://drive.google.com/uc?id=1hGfuhdEPjJSiM-KA7kZ9JyGsFNBKypdg",4));
                                    opciones.add(new Opcion("Mirage", "https://drive.google.com/uc?id=1RFc9xIQcdKKTv5B4dq065jDSv7ufYrNg",4));
                                    opciones.add(new Opcion("Pepe Grillo", "https://drive.google.com/uc?id=1EhzX68-NRkUcR2nWUqBkORDMR50l903i",4));
                                    opciones.add(new Opcion("Piglet", "https://drive.google.com/uc?id=1RdA5Eu1uOVmgmjAYaLiseOveMEVUVCEv",4));
                                    opciones.add(new Opcion("Tia Dalma", "https://drive.google.com/uc?id=1deC3h3HhBO12bZlr5HIYLvkGYllF5mQN",4));
                                    opciones.add(new Opcion("Bella", "https://drive.google.com/uc?id=122TLUXo-jB6VB6KSGu5EaXmgFU_NJerX",4));
                                    opciones.add(new Opcion("Cenicienta", "https://drive.google.com/uc?id=12dZ7TkLxx74uoO4fy2lua-hEqkatkhpY",4));
                                    opciones.add(new Opcion("Destiny", "https://drive.google.com/uc?id=14NFuggHRxy_BR7GI3aNc77X_qmvmH3wG",4));
                                    opciones.add(new Opcion("Golfo", "https://drive.google.com/uc?id=1s7T-63KL209D6ykejlJyVdO0xupQmenV",4));
                                    opciones.add(new Opcion("Little John", "https://drive.google.com/uc?id=1yhAmTzqv3hsvjPWwyPstkFf5yVQopZG2",4));
                                    opciones.add(new Opcion("Periwinkle", "https://drive.google.com/uc?id=1Wt1RBS_S6zoKYdR8UwYjQqAvUsB_MI-b",4));
                                    opciones.add(new Opcion("Scuttle", "https://drive.google.com/uc?id=1zlWY_z1To7BWZLjq5uHMyeejlHI__ode",4));
                                    opciones.add(new Opcion("Sombrerero Loco", "https://drive.google.com/uc?id=1EAlF0EgU3DYYdqQjPtk1mAuvIBYhKARX",4));
                                    opciones.add(new Opcion("Yzma", "https://drive.google.com/uc?id=1-miRAgRE3lWya3Jy_H72_GydRv5se7iA",4));
                                    opciones.add(new Opcion("Zazu", "https://drive.google.com/uc?id=1lC9A8trn2GkglUIvrNEU-LAnQN-QX90R",4));
                                    opciones.add(new Opcion("Zeus", "https://drive.google.com/uc?id=151e9qugZdNSWisbgWFrFecxIrpgG553j",4));

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
