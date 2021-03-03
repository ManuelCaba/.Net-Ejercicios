
public class TestWallet {
	
	public void test1() {
		
		Object monitor = new Object();
		
		Wallet carteraLeo = new Wallet("prueba");
		carteraLeo.setBalance(1000);
		carteraLeo.setMonitor(monitor);
		
		
		Wallet carteraFernando = new Wallet("prueba1");
		carteraFernando.setBalance(1000);
		carteraFernando.setMonitor(monitor);
		
		Wallet carteraMiguel = new Wallet("prueba2");
		carteraMiguel.setMonitor(monitor);
		
        Thread hiloLeo = new Thread(() -> {
        	while(carteraLeo.getBalance() > 0)
        	{
        		carteraLeo.transferTo(carteraMiguel, "prueba", 1);
        	}
        	});
        
        Thread hiloFernando = new Thread(() -> {
        	while(carteraFernando.getBalance() > 0)
        	{
        		carteraFernando.transferTo(carteraMiguel, "prueba1", 1);
        	}
        	});
        
        hiloLeo.start();
        hiloFernando.start();
        
        try {
			hiloLeo.join();
			hiloFernando.join();
			System.out.println(carteraMiguel.getBalance());
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
	}
	
	public void test2() {
		Object monitor = new Object();
		
		Wallet carteraManuel = new Wallet("manuel");
		carteraManuel.setBalance(1000000);
		carteraManuel.setMonitor(monitor);
		
		//Sí Raúl, tú eres mi artista favorito
		Wallet carteraRaul = new Wallet("raul");
		carteraRaul.setBalance(0);
		carteraRaul.setMonitor(monitor);
		
        Thread hiloManuel = new Thread(new HilosRunnable2(carteraRaul,carteraManuel,"manuel",1));
        
        Thread hiloRaul = new Thread(new HilosRunnable2(carteraRaul,carteraManuel,"incorrecto",1));
        
        hiloManuel.start();
        hiloRaul.start();
        
        try {
			hiloManuel.join();
			hiloRaul.join();
			System.out.println(carteraRaul.getBalance());
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void test3() //No terminado
	{
		Object monitor = new Object();
		Object monitor2 = new Object();
		
		Wallet c1 = new Wallet("prueba");
		c1.setBalance(1000);
		c1.setMonitor(monitor);
		
		Wallet c2 = new Wallet("prueba1");
		c2.setBalance(1000);
		c2.setMonitor(monitor);
		
		Wallet c3 = new Wallet("prueba2");
		c3.setBalance(0);
		c3.setMonitor(monitor);
		
		Wallet c4 = new Wallet("prueba3");
		c4.setBalance(0);
		c4.setMonitor(monitor);
		
        Thread h1 = new Thread(new HilosRunnable3(c3,c1,"prueba",1, monitor2));
        
        Thread h2 = new Thread(new HilosRunnable3(c4,c3,"prueba2",1, monitor2));
        
        Thread h3 = new Thread(new HilosRunnable3(c4,c2,"prueba1",1, monitor2));

        h1.start();
        h2.start();
        h3.start();
        
        try {
			h1.join();
			h2.join();
			h3.join();
			System.out.println(c4.getBalance());
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}

}
