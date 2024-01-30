package actions;

import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;


public class AddressValidation {
	
	public synchronized static String validateAddress(String address) {
		
		String addressCheck = "";
		String apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K";

        try {
            HttpClient httpClient = HttpClients.createDefault();
            String url = "http://www.mapquestapi.com/geocoding/v1/address?key=" +
                         apiKey + "&location=" + address.replace(" ", "+");
            
            HttpGet httpGet = new HttpGet(url);
            String responseBody = EntityUtils.toString(httpClient.execute(httpGet).getEntity());

            JSONObject jsonResponse = new JSONObject(responseBody);
            JSONArray results = jsonResponse.getJSONArray("results");

            if (results.length() > 0) {
                JSONObject result = results.getJSONObject(0);
                if (result.has("locations")) {
                    JSONArray locations = result.getJSONArray("locations");
                    System.out.println(locations);
                    if (locations.length() > 0) {
                    	JSONObject location = locations.getJSONObject(0);
                        String geoCodeQuality = location.getString("geocodeQualityCode");

                        if (!geoCodeQuality.isEmpty() && (geoCodeQuality.startsWith("B") || geoCodeQuality.startsWith("P") || geoCodeQuality.startsWith("L"))) {
                        	addressCheck = "Valid";
                        } else {
                        	addressCheck = "Invalid";
    					}                        
                    } 
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addressCheck;
	}
	
	public static void main(String[] args) {
		
		String check = validateAddress("1 Burns Street, Leicester, LE2 6, GB");
		//String checkin = "Burns Street" + ", " + "Leicester" + ", " + "England";
		System.out.println(check);
	}

}
