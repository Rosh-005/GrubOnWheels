package servlet;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import org.apache.http.client.HttpClient;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;


@WebServlet("/GeocodeServlet")
public class GeocodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected synchronized void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userAddress = request.getParameter("userAddress");

		String apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K";
		String geocodingUrl = "http://www.mapquestapi.com/geocoding/v1/address?key=" + apiKey + "&location="
				+ userAddress.replace(" ", "+");

		try {
			HttpClient httpClient = HttpClients.createDefault();

			HttpGet httpGet = new HttpGet(geocodingUrl);
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
						BigDecimal latitude = location.getJSONObject("latLng").getBigDecimal("lat");
						BigDecimal longitude = location.getJSONObject("latLng").getBigDecimal("lng");
						System.out.println("Latitude: " + latitude);
						System.out.println("Longitude: " + longitude);
						
						JSONObject responseData = new JSONObject();
                        responseData.put("status", "OK");
                        responseData.put("latitude", latitude);
                        responseData.put("longitude", longitude);

                        // Set the response content type to JSON
                        response.setContentType("application/json");

                        // Write the JSON response to the servlet's output stream
                        response.getWriter().write(responseData.toString());
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
