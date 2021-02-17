package clases;

import java.util.Random;

public class NumerosAleatorios implements Runnable {


	public void run() {
		Random random = new Random();
		
		for(int i = 0; i < 10; i++)
		{
			System.out.println(random.nextInt(5) + 1);
		}
		
	}

}
