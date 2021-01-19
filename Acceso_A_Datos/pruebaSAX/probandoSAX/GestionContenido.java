package probandoSAX;


import org.xml.sax.helpers.*;
import org.xml.sax.*;
public class GestionContenido extends DefaultHandler {
	
	private Jugador jugadorActual;
	private String etiquetaActual;
	private Jugador jugadorGanador;
	private String numeroPartida;

    public GestionContenido() {
        super();
    }
    @Override
    public void startDocument(){
    }
    @Override
    public void endDocument(){
    }
    @Override
    public void startElement(String uri, String nombre, String nombreC, Attributes att){
        
        //Almacenamos la etiqueta actual del lector xml
    	etiquetaActual = nombreC; 
        
        if(nombreC.equals("partida")) //Si nos encontramos en la etiqueta partida
        {
        	//Almacenamos el valor del id de la partida actual
        	numeroPartida = att.getValue("id");
        }
    }
    @Override
    public void endElement(String uri, String nombre, String nombreC){
    	
    	switch(nombreC) //Según la etiqueta de cierre
    	{
    		case "jugador":
    			
    			double cantidadGanador;
    			double cantidadActual = jugadorActual.getCantidadJugada();
    			
				if(jugadorGanador != null) //Si hay jugador ganador
				{
					//Guardamos la puntuación de ambos jugadores
					cantidadGanador = jugadorGanador.getCantidadJugada();
					
					//Comprobamos el ganador
					if(cantidadActual <= 7.5)
					{
						if(cantidadGanador < cantidadActual)
						{
							jugadorGanador = new Jugador(jugadorActual);
						}
					}
				}
				else if(cantidadActual <= 7.5) //Si la cantidad del jugador actual no supera 7'5
				{
					//Almacenamos el jugador actual en el jugador ganador
					jugadorGanador = new Jugador(jugadorActual);
				}
				
    		break;
    		
    		case "partida":
    			
    			//Mostramos el resultado de la partida
    			System.out.println("Partida "+numeroPartida+" - Ganador/a: "+jugadorGanador.getNombre());
    			
    			//Reseteamos los jugadores
    			jugadorGanador = null;
    			jugadorActual = null;
    		break;
    	}
    }
    @Override
    public void characters (char[] ch, int inicio, int longitud)
            throws SAXException{
    	
    	switch(etiquetaActual) //Según la etiqueta actual
    	{
    		case "nombre":
    			String nombre = new String(ch, inicio, longitud);
    			
    			if(!nombre.equals("\n")) //Si el nombre no es un salto de línea
    			{
    				//Creamos un nuevo jugador actual con el nombre
    				jugadorActual = new Jugador(new String(ch, inicio, longitud));
    			}
    		break;
    		case "numero":
    			
    			String numero = new String(ch, inicio, longitud);
    			
    			if(!numero.equals("\n")) //Si el número no es un salto de línea
    			{
        			double cantidad = 0;
        			
        			try
        			{
        				//Si el valor es parseable a double lo almacenamos en cantidad
        				cantidad = Double.parseDouble(numero);
        			}
        			catch(NumberFormatException e)
        			{
        				//En caso contrario almacenamos 0'5 (Debido a ser una figura)
        				cantidad = 0.5;
        			}
        			
        			//Sumamos la cantidad de la jugada al jugador actual
        			jugadorActual.setCantidadJugada(jugadorActual.getCantidadJugada() + cantidad);
    			}
    			
			break;
    		
    	}
    }
}
// FIN GestionContenido
