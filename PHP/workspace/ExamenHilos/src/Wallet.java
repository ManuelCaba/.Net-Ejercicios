
public class Wallet {

	private double balance;
	private String password;
	private boolean incorrecta = true;
	private int tiempoEspera = 10;
	private Object monitor;
	
	public Wallet(String password)
	{
		this.balance = 0;
		this.password = password;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}
	
	public void setMonitor(Object monitor) {		
		this.monitor = monitor;	
	}
	
	//Métodos
	public boolean transferTo(Wallet walletDestino, String password, double number)
	{
		boolean transferido = false;
		
		if(number >= 0)
		{
			if(number <= this.getBalance())
			{
				if(password.equals(this.password))
				{		
					synchronized(monitor)
					{
						incorrecta = false;
						tiempoEspera = 10;	
						monitor.notifyAll();
						this.balance-=number;
						walletDestino.balance+=number;
					}
				}
				else
				{
					synchronized(monitor)
					{
						if(incorrecta)
						{
							tiempoEspera = tiempoEspera * 2;
						}
						incorrecta = true;
						
						try {

							monitor.wait(tiempoEspera);				
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}

				}
			}
		}
		
		return transferido;
	}
}
