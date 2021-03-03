
public class HilosRunnable3 implements Runnable {
	private Wallet carteraDestino;
	private Wallet carteraOrigen;
	private String password;
	private int number;
	private Object monitor;
	private static boolean terminado = false;
	
	public HilosRunnable3(Wallet carteraDestino, Wallet carteraOrigen, String password, int number, Object monitor)
	{
		this.carteraDestino = carteraDestino;
		this.carteraOrigen = carteraOrigen;
		this.password = password;
		this.number = number;
		this.monitor = monitor;
	}
	
	public void run() {
		
    	while(!terminado)
    	{
    		synchronized(monitor){
    			if(carteraOrigen.getBalance() > 0)
    			{
        			carteraOrigen.transferTo(carteraDestino, password, number);
        			if(carteraDestino.getBalance() == 2000)
        			{
        				terminado = true;
        			}
        			monitor.notify();
    			}
    			else
    			{
	  				try {
						monitor.wait();
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}


    			}
    			
    		}
    	}

	}
}
