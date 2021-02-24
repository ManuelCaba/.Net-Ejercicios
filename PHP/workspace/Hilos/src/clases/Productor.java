package clases;

import main.ProductorConsumidor;

public class Productor implements Runnable {
	
	private Object hiloPrincipal;
	private int numero = 8053;
	
	public void run() {
		
		while(ProductorConsumidor.numerosPrimos.size() <= 10)
		{
			numero = generarProximoPrimo(numero);
			ProductorConsumidor.numerosPrimos.add(numero);
			synchronized(hiloPrincipal)
			{
				hiloPrincipal.notify();
				if(ProductorConsumidor.numerosPrimos.size() == 10)
				{
					try {
						hiloPrincipal.wait();
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

			}
		}

	}
	
	public void setHiloPrincipal(Object object)
	{
		hiloPrincipal = object;
	}
	
	public int generarProximoPrimo(int numero)
	{
		numero++;
		
		while(!esPrimo(numero))
		{
			numero++;
		}
		
		return numero;
	}
	
	public boolean esPrimo(int numero){
		  int contador = 2;
		  boolean primo=true;
		  while ((primo) && (contador!=numero)){
		    if (numero % contador == 0)
		      primo = false;
		    contador++;
		  }
		  return primo;
		}

}
