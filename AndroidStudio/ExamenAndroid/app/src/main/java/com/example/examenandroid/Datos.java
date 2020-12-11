package com.example.examenandroid;

import android.app.Application;
import android.content.res.Configuration;

import java.util.ArrayList;

// IMPORTANTE: No olvides añadir el atributo android:name=".Datos" al elemento "application"
// en el manifest. De esta forma, cuando hagamos una llamada a Context.getApplication()
// recibirás la instancia de Application (en este caso una instancia de la clase "Datos")
// Application usa el patrón Singleton, por lo que solo habrá una instancia de Datos.
// Por ejemplo, desde una actividad podríamos hacer lo siguiente:
// objDatos = (Datos) getApplication();

public class Datos extends Application {

    // Ejemplo de dato que mantendremos en memoria accesible globalmente
    private ArrayList<Object> listaEjemplo;

    // Called when the application is starting,
    // before any other application objects have been created.
    @Override
    public void onCreate() {
        super.onCreate();

        //Rellenamos la lista
        // LA APP DEBE FUNCIONAR INDEPENDIENTEMENTE DEL NÚMERO DE DESARROLLADORES Y DE JUEGOS, Y DEL ORDEN EN QUE SE DISPONGAN
        listaEjemplo = new ArrayList<>();
        listaEjemplo.add(new Desarrollador("Sega",R.drawable.sega75x75,1960,"Sega Corporation es una multinacional japonesa de desarrollo y distribución de videojuegos"));
        listaEjemplo.add(new Juego("FIFA 21", "FIFA 21 es un videojuego de simulación de fútbol del año 2020 disponible para Microsoft Windows, PlayStation 4, Xbox One y Nintendo Switch el 9 de octubre de 2020, y aparte es el primer videojuego de la serie FIFA para Google Stadia, PlayStation 5 y Xbox Series X|S."));
        listaEjemplo.add(new Desarrollador("EA",R.drawable.logoea75x75,1982,"Electronic Arts es una empresa estadounidense desarrolladora y distribuidora de videojuegos"));
        listaEjemplo.add(new Desarrollador("2K",R.drawable.logo2k75x75,2005,"2K es una empresa distribuidora de videojuegos con sede en Novato"));
        listaEjemplo.add(new Juego("NBA 2K21", "NBA 2K21 es un videojuego de simulación de baloncesto desarrollado por Visual Concepts y publicado por 2K Sports, basado en la Asociación Nacional de Baloncesto. Es la 22a entrega de la franquicia NBA 2K y la sucesora de NBA 2K20."));
        listaEjemplo.add(new Juego("Cyberpunk 2077", "Cyberpunk 2077 es un videojuego desarrollado y publicado por CD Projekt"));
        listaEjemplo.add(new Desarrollador("Ubisoft",R.drawable.logoubisoft75x75,1986,"Ubisoft Entertainment es una compañía francesa desarrolladora y distribuidora de videojuegos"));
        listaEjemplo.add(new Juego("Destiny 2", "Destiny 2 es un videojuego de disparos en primera persona, desarrollado y publicado por Bungie. Se lanzó el 6 de septiembre de 2017 para PlayStation 4 y Xbox One, y el 24 de octubre del mismo año para Microsoft Windows. Es la secuela de Destiny y sus posteriores expansiones."));
        listaEjemplo.add(new Desarrollador("Warner Bros",R.drawable.wb75x75,1993,"Warner Bros Interactive Entertainment es una empresa desarrolladora, distribuidora y licenciadora de videojuegos a nivel mundial de títulos propios y de terceros"));
        listaEjemplo.add(new Juego("Borderlands 3", "Borderlands 3 es un videojuego de disparos en primera persona con elementos de rol, se trata de la secuela del videojuego de 2012, Borderlands 2. Fue desarrollado por Gearbox Software y distribuido por 2K Games para las plataformas Google Stadia, Microsoft Windows, PlayStation 4, Xbox One y Pc"));
        listaEjemplo.add(new Juego("Assassin's Creed Valhalla", "Assassin's Creed Valhalla es un videojuego desarrollado por Ubisoft Montreal y publicado por Ubisoft"));




    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
    }


    @Override
    public void onLowMemory() {
        super.onLowMemory();
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
    }

    public ArrayList<Object> getListaEjemplo() {
        return listaEjemplo;
    }

    public void setListaEjemplo(ArrayList<Object> listaEjemplo) {
        this.listaEjemplo = listaEjemplo;
    }
}
