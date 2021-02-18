package clases;

public class NumerosRepetidos implements Runnable {
	
	private static int[] array;
	int indiceInicio;
	int indiceFinal;
	private static int repetidosTotales = 0;
	private static int hilosTerminados = 0;
	private static Object hiloPrincipal;
	
	public void run() {

			int repetidos = 0;
			int primerNumero;
			int segundoNumero;

			
			for(int i = indiceInicio; i <= indiceFinal; i++)
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
			
			synchronized(hiloPrincipal)
			{
			repetidosTotales += repetidos;
			hilosTerminados++;
			if(hilosTerminados == 2)
			{
				hiloPrincipal.notifyAll();
			}
		}
	}
	
	public static void setArray(int[] arrayNumeros)
	{
		array = arrayNumeros;
	}
	
	public static int getRepetidosTotales()
	{
		return repetidosTotales;
	}
	
	public void setHiloPrincipal(Object object)
	{
		hiloPrincipal = object;
	}
	
	public void setIndices(int inicio, int iFinal)
	{
		this.indiceInicio = inicio;
		this.indiceFinal = iFinal;
	}

}
