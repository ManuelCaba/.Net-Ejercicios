package src;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.*;
import org.xml.sax.*;

public class LectorSAX {
    XMLReader procesadorXML;
    GestionContenido gestor;
    InputSource archivoXML;
    public LectorSAX (String nombreArchivo)
    {
        try 
        {
            SAXParserFactory parserFactory = SAXParserFactory.newInstance();
            SAXParser parser = parserFactory.newSAXParser();
            procesadorXML = parser.getXMLReader();
        } 
        catch (SAXException ex) 
        {
            Logger.getLogger(LectorSAX.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        gestor = new GestionContenido();
        procesadorXML.setContentHandler(gestor);
        archivoXML = new InputSource(nombreArchivo);
    }
    
    void andale()
    {
        try 
        {
            procesadorXML.parse(archivoXML);
        } 
        catch (IOException ex) 
        {
            Logger.getLogger(LectorSAX.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (SAXException ex) 
        {
            Logger.getLogger(LectorSAX.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
// Fin PruebaSAX1
