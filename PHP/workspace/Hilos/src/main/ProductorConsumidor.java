package main;

import java.util.LinkedList;

import clases.Consumidor;
import clases.JuegoNumeroAleatorio;
import clases.Productor;

public class ProductorConsumidor {
	
	public static LinkedList<Integer> numerosPrimos = new LinkedList<Integer>();

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Object monitor = new Object();
		Consumidor consumidor = new Consumidor();
		consumidor.setHiloPrincipal(monitor);
		Productor productor = new Productor();
		productor.setHiloPrincipal(monitor);
		Thread threadConsumidor = new Thread(consumidor);
		Thread threadProductor = new Thread(productor);
		threadConsumidor.start();
		threadProductor.start();


	}

}
