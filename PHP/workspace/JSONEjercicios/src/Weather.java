import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Weather {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	    String sURL = "http://localhost:8080/APIRestTiendaOnline/index.php/Product/1"; //just a string

	    // Connect to the URL using java's native library
	    try {
			JSONArray arrayPadre = new JSONArray(sURL);
			
			System.out.println(arrayPadre.toString());
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} /*catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	    
		
		//JSONObject objetoPadre = new JSONObject("https://api.openweathermap.org/data/2.5/onecall?lat=9.70383&lon=124.048286&exclude=hourly,current,minutely,alerts&appid=ae8e1449f1ba12886ccd97d9ae5698e8");
	}

}
