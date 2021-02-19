package metodos;

import java.util.Random;

import clases.JuegoNumeroAleatorio;
import clases.NumerosRepetidos;

public class MetodosEjercicio4 {

	public int[] rellenarArrayAleatorio(int longitud)
	{
		Random aleatorio = new Random();
		int[] array = new int[longitud];
		
		for(int i = 0; i < longitud; i++)
		{
			array[i] = aleatorio.nextInt(8) + 1;
		}
		
		return array;
	}
	
	public void pintarArray(int[] array)
	{
		System.out.print("{");
		for(int i = 0; i < array.length; i++)
		{
			System.out.print(array[i]);
			if(i != array.length - 1)
			{
				System.out.print(",");
			}
		}
		System.out.print("}");
	}
	
	public int sumarRepetidos(int[] array)
	{
		long start = System.currentTimeMillis();
		
		int repetidos = 0;
		int primerNumero;
		int segundoNumero;
		
		for(int i = 0; i < array.length; i++)
		{
			primerNumero = array[i];
			
			for(int j = 0; j < array.length; j++)
			{
				if(i != j)
				{
					segundoNumero = array[j];
					if(primerNumero == segundoNumero)
					{
						repetidos += primerNumero;
					}
				}
			}
		}
		
		long end = System.currentTimeMillis();
		
		System.out.println("DEBUG: Logic A took " + (end - start) + " MilliSeconds");
		
		return repetidos;
	}
	
	public int sumarRepetidosHilos(int[] array)
	{
		long start = System.currentTimeMillis();
		NumerosRepetidos primeraMitad = new NumerosRepetidos();
		NumerosRepetidos segundaMitad = new NumerosRepetidos();
		primeraMitad.setHiloPrincipal(this);
		segundaMitad.setHiloPrincipal(this);
	    
	    NumerosRepetidos.setArray(array);
	    primeraMitad.setIndices(0, (array.length / 2) - 1);
	    segundaMitad.setIndices((array.length / 2), (array.length) - 1);
		
		Thread thread = new Thread(primeraMitad);
		Thread thread1 = new Thread(segundaMitad);
		
		thread.start();
		thread1.start();
		
		try {
			synchronized(this)
			{
				this.wait();
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		
		System.out.println("DEBUG: Logic A took " + (end - start) + " MilliSeconds");
		
		return NumerosRepetidos.getRepetidosTotales();
	}
}
