package probandoSAX;


import org.xml.sax.helpers.*;
import org.xml.sax.*;
public class GestionContenido extends DefaultHandler {
	
	private Jugador jugadorAnterior;
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
        etiquetaActual = nombreC;
        
        if(nombreC.equals("partida"))
        {
        	numeroPartida = att.getValue("id");
        }
    }
    @Override
    public void endElement(String uri, String nombre, String nombreC){
    	
    	switch(nombreC)
    	{
    		case "jugador":
    			
    			double cantidadGanador;
    			double cantidadActual = jugadorActual.getCantidadJugada();;
    			double cantidadAnterior;
    			
    			if(jugadorAnterior != null)
    			{
    				
    				if(jugadorGanador != null)
    				{
    					cantidadGanador = jugadorGanador.getCantidadJugada();
    					cantidadAnterior = jugadorAnterior.getCantidadJugada();
    					
    					if(cantidadActual <= 7.5)
    					{
    						if(cantidadGanador < cantidadActual)
    						{
    							jugadorGanador = new Jugador(jugadorActual);
    						}
    					}
    				}
    				else if(cantidadActual <= 7.5)
    				{
    					jugadorGanador = new Jugador(jugadorActual);
    				}
    			}
				else if(cantidadActual <= 7.5)
				{
					jugadorGanador = new Jugador(jugadorActual);
				}
    			
    			jugadorAnterior = new Jugador(jugadorActual);
    		break;
    		
    		case "partida":
    			
    			System.out.println("Partida "+numeroPartida+" - Ganador/a: "+jugadorGanador.getNombre());
    			
    			jugadorGanador = null;
    			jugadorAnterior = null;
    			jugadorActual = null;
    		break;
    	}
    }
    @Override
    public void characters (char[] ch, int inicio, int longitud)
            throws SAXException{
    	
    	switch(etiquetaActual)
    	{
    		case "nombre":
    			String nombre = new String(ch, inicio, longitud);
    			
    			if(!nombre.equals("\n"))
    			{
    				jugadorActual = new Jugador(new String(ch, inicio, longitud));
    			}
    		break;
    		case "numero":
    			
    			String numero = new String(ch, inicio, longitud);
    			
    			if(!numero.equals("\n"))
    			{
        			double cantidad = 0;
        			
        			try
        			{
        					cantidad = Double.parseDouble(numero);
        			}
        			catch(NumberFormatException e)
        			{
        				cantidad = 0.5;
        			}
        			
        			jugadorActual.setCantidadJugada(jugadorActual.getCantidadJugada() + cantidad);
    			}
    			
			break;
    		
    	}
    }
}
// FIN GestionContenido
