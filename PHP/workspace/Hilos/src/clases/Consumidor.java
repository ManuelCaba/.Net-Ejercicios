package clases;

import main.ProductorConsumidor;

public class Consumidor implements Runnable {
	
	private Object hiloPrincipal;
	
	public void run() {
		
		while(true)
		{
			synchronized(hiloPrincipal)
			{
				if(ProductorConsumidor.numerosPrimos.isEmpty())
				{
					try {
						hiloPrincipal.wait();
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

			}
			
			synchronized(hiloPrincipal)
			{
				System.out.println(ProductorConsumidor.numerosPrimos.getFirst());
				ProductorConsumidor.numerosPrimos.removeFirst();
				hiloPrincipal.notify();
			}

		}

	}
	
	public void setHiloPrincipal(Object object)
	{
		hiloPrincipal = object;
	}

}
