package clases;

import java.util.Random;

public class JuegoNumeroAleatorio implements Runnable {
	
	private boolean continuarJugando = true;
	private int numeroActual;
	

	public void run() {
		// TODO Auto-generated method stub
		Random random = new Random();
		
		while(continuarJugando)
		{
			numeroActual = random.nextInt(9) + 1;
			System.out.println("Número aleatorio generado: "+numeroActual);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void setContinuarJugando(boolean continuarJugando)
	{
		this.continuarJugando = continuarJugando;
	}
	
	public int getNumeroActual()
	{
		return numeroActual;
	}

}
