package clases;

public class Hola implements Runnable {
	
	private static Object monitor = new Object();
	
	@Override
	public void run() {
		synchronized(monitor)
		{
			for(int i = 0; i < 50; i++)
			{
				System.out.println("Hola");
				monitor.notify();
				try {
					monitor.wait();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	public static Object getMonitor()
	{
		return monitor;
	}

}
