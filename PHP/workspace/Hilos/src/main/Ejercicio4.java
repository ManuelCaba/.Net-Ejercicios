package main;

import java.util.Scanner;

import metodos.MetodosEjercicio4;

public class Ejercicio4 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner teclado = new Scanner(System.in);
		MetodosEjercicio4 utiles = new MetodosEjercicio4();
		int longitud;
		int[] array;
		
		System.out.print("Escriba la longitud del array: ");
		longitud = teclado.nextInt();
		
		
		array = utiles.rellenarArrayAleatorio(longitud);
		
		utiles.pintarArray(array);
		
		System.out.print(": "+utiles.sumarRepetidosHilos(array));
	}

}
