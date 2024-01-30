package actions;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

public class DistanceCalculator {
	public static void main(String[] args) {
		String postcode1 = "1 Burns Street, Leicester,Leicestershire, United Kingdom";
		String postcode2 = "90 Aylestone Road, Leicester, United Kingdom";
		String postcode3 = "13 Rutland Avenue, Leicester, United Kingdom";
		List<String> address = new ArrayList<String>();
		address.add(postcode1.replace(" ", "+"));
		address.add(postcode2.replace(" ", "+"));
		address.add(postcode3.replace(" ", "+"));
	}

	public synchronized double calculateDistance(String userAddress, String restaurantAddress) {
		
		double roadDistance = 0.0;
		String apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K";

		try {
			String apiUrl = "https://www.mapquestapi.com/directions/v2/route?key=" + apiKey + "&from="
					+ userAddress.replace(" ", "+") + "&to=" + restaurantAddress.replace(" ", "+");

			URL url = new URL(apiUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");

			int responseCode = connection.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				StringBuilder response = new StringBuilder();

				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();

				JSONObject jsonResponse = new JSONObject(response.toString());
				JSONObject route = jsonResponse.getJSONObject("route");
				roadDistance = route.getDouble("distance");
				System.out.println("Road distance between the two postcodes: " + roadDistance + " miles");

			} else {
				System.out.println("Request failed with response code: " + responseCode);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roadDistance;
	}
	
	public synchronized double calculateOptimizedRoute(List<String> addresses) {
		
		String apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K";
		String addressJson = new JSONArray(addresses).toString();
		try {
            String urlStr = "https://www.mapquestapi.com/directions/v2/optimizedroute"
                    + "?key=" + apiKey
                    + "&json={\"locations\":" + addressJson + "}";

            URL url = new URL(urlStr);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                InputStream responseStream = connection.getInputStream();
                Scanner scanner = new Scanner(responseStream);
                StringBuilder response = new StringBuilder();

                while (scanner.hasNextLine()) {
                    response.append(scanner.nextLine());
                }

                scanner.close();

                // Parse JSON response
                String jsonResponse = response.toString();
                double distance = parseDistanceFromJson(jsonResponse);

                // Return the calculated distance
                return distance;
            } else {
                System.out.println("Error response code: " + responseCode);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return -1;
	}
	
	public synchronized double parseDistanceFromJson(String jsonResponse) {
        JSONTokener tokener = new JSONTokener(jsonResponse);
        JSONObject jsonObject = new JSONObject(tokener);
        
        int statusCode = jsonObject.getJSONObject("info").getInt("statuscode");
        if (statusCode == 0) {
            JSONArray routeArray = jsonObject.getJSONObject("route").getJSONArray("legs");
            if (routeArray.length() > 0) {
                JSONObject legObject = routeArray.getJSONObject(0);
                double distance = legObject.getDouble("distance");
                return distance;
            }
        } else {
            JSONArray messagesArray = jsonObject.getJSONObject("info").getJSONArray("messages");
            for (int i = 0; i < messagesArray.length(); i++) {
                String errorMessage = messagesArray.getString(i);
                System.out.println("Error message: " + errorMessage);
            }
        }
        
        return -1; // Return a negative value to indicate an error
    }
}