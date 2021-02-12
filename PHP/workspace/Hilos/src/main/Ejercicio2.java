package main;

import clases.Adios;
import clases.Hola;

public class Ejercicio2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Hola hola = new Hola();
		Adios adios = new Adios();
		Thread threadHola = new Thread(hola);
		Thread threadAdios = new Thread(adios);

		threadHola.start();
		threadAdios.start();

	}

}
