package clases;

public class Adios implements Runnable {
	
	@Override
	public void run() {
		synchronized(Hola.getMonitor())
		{
			Object monitor = Hola.getMonitor();
			for(int i = 0; i < 50; i++)
			{
				System.out.println("Adios");
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

}
