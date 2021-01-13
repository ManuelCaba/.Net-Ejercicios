package probandoSAX;


import org.xml.sax.helpers.*;
import org.xml.sax.*;
public class GestionContenido extends DefaultHandler {
	
	private Jugador jugadorAnterior;
	private Jugador jugadorActual;
	private String etiquetaActual;

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
    }
    @Override
    public void endElement(String uri, String nombre, String nombreC){
    	
    	switch(etiquetaActual)
    	{
    		case "jugador":
    			jugadorAnterior = new Jugador(jugadorActual);
    		break;
    	}
    }
    @Override
    public void characters (char[] ch, int inicio, int longitud)
            throws SAXException{
    	
    	switch(etiquetaActual)
    	{
    		case "jugador":
    			jugadorActual = new Jugador(new String(ch, inicio, longitud));
    		break;
    		case "numero":
    			String numero = new String(ch, inicio, longitud);
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
    			
			break;
    		
    	}
    }
}
// FIN GestionContenido
