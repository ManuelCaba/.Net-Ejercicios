package main;

import java.util.Scanner;

import clases.JuegoNumeroAleatorio;
import clases.NumerosAleatorios;

public class Ejercicio3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner teclado = new Scanner(System.in);
		int numeroElegido;
		boolean continuarJugando = true;
		JuegoNumeroAleatorio numerosAleatorios = new JuegoNumeroAleatorio();
		Thread thread = new Thread(numerosAleatorios);
		thread.start();
		
		while(continuarJugando)
		{
			numeroElegido = teclado.nextInt();
			if(numeroElegido == numerosAleatorios.getNumeroActual())
			{
				continuarJugando = false;
				numerosAleatorios.setContinuarJugando(continuarJugando);
			}
		}
	}

}
