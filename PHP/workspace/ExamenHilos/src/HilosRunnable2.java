

public class HilosRunnable2 implements Runnable {
	
	private Wallet carteraDestino;
	private Wallet carteraOrigen;
	private String password;
	private int number;
	private static boolean terminado = false;
	
	public HilosRunnable2(Wallet carteraDestino, Wallet carteraOrigen, String password, int number)
	{
		this.carteraDestino = carteraDestino;
		this.carteraOrigen = carteraOrigen;
		this.password = password;
		this.number = number;
	}
	
	public void run() {
		
    	while(carteraOrigen.getBalance() > 0 && !terminado)
    	{
    		carteraOrigen.transferTo(carteraDestino, password, number);
    	}
    	terminado = true;
	}

}
