import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import org.json.JSONArray;
import org.json.JSONObject;

public class Weather {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	    String sURL = "https://api.openweathermap.org/data/2.5/onecall?lat=9.70383&lon=124.048286&exclude=hourly,current,minutely,alerts&appid=ae8e1449f1ba12886ccd97d9ae5698e8"; //just a string

	    // Connect to the URL using java's native library
	    URL url = null;
		try {
			url = new URL(sURL);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    try {
			URLConnection request = url.openConnection();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		
		//JSONObject objetoPadre = new JSONObject("https://api.openweathermap.org/data/2.5/onecall?lat=9.70383&lon=124.048286&exclude=hourly,current,minutely,alerts&appid=ae8e1449f1ba12886ccd97d9ae5698e8");
	}

}
