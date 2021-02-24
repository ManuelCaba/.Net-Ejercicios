package clases;

import main.ProductorConsumidor;

public class Consumidor implements Runnable {
	
	private Object hiloPrincipal;
	
	public void run() {
		
		while(!ProductorConsumidor.numerosPrimos.isEmpty())
		{
			System.out.println(ProductorConsumidor.numerosPrimos.getFirst());
			ProductorConsumidor.numerosPrimos.removeFirst();
			synchronized(hiloPrincipal)
			{
				hiloPrincipal.notify();
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
		}

	}
	
	public void setHiloPrincipal(Object object)
	{
		hiloPrincipal = object;
	}

}
