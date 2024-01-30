 setInterval(sendLocationUpdate, 5000);  // Send location updates every 5 seconds
    // Function to send location updates
    function sendLocationUpdate() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude;
                var lng = position.coords.longitude;
                console.log("Latitude: " +lat+ " Longitude: "+lng);
                // Use AJAX to send location update to the server
                $.ajax({
                    type: "POST",
                    url: "UpdateDeliveryLocation",
                    data: {
                        lat: lat,
                        lng: lng
                    },
                    success: function(response) {
                        console.log("Location updated successfully. Server response:", response);
                    },
                    error: function(error) {
                        console.error("Error updating location:", error);
                    }
                });
            }, function(error) {
            	if (error.code === error.PERMISSION_DENIED) {
                    // Display a message in the HTML encouraging the user to grant access
                    alert("Please grant access to your location.");
            	}
                console.error("Error getting location:", error);
            });
        } else {
            console.log("Geolocation is not supported by this browser.");
        }
    }

   