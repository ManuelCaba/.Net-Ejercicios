package main;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.JFrame;

import clases.NumerosAleatorios;

public class Ejercicio1{

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		NumerosAleatorios numerosAleatorios = new NumerosAleatorios();
		Thread thread = new Thread(numerosAleatorios);
		thread.start();
	}

}
