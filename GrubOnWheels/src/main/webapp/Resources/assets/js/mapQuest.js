var addressFieldsVisible = false;
        var isAllFieldsFilled = false;
        console.log("User Address: " + userAddress); 

        function toggleAddressFields() {
            var addressFields = document.getElementsByClassName("address-class");
            var existingAddressField = document.getElementById("existingAddress");
            if (!addressFieldsVisible) {
                userAddress = existingAddressField.value;
                existingAddressField.value = ''; 
            } else {
                existingAddressField.value = userAddress;
            }
            	for (var i = 0; i < addressFields.length; i++) {
                    addressFields[i].style.display = addressFieldsVisible ? "none" : "block";
                }
                addressFieldsVisible = !addressFieldsVisible;
                return false;
        }

        function updateUserAddress() {
            var address1 = document.getElementById("address1").value;
            var address2 = document.getElementById("address2").value;
            var addressCity = document.getElementById("addressCity").value;

            userAddress = address1 + ", " + address2 + ", " + addressCity + ", United Kingdom";
            console.log("Updated User Address:", userAddress);

            if (address1 && address2 && addressCity) {
                isAllFieldsFilled = true;
            } else {
                isAllFieldsFilled = false;
            }

            // Validate the entered address using AJAX when all fields are filled
            if (isAllFieldsFilled) {
                validateAddress(userAddress);
            }
        }

        function validateAddress(address) {
            console.log("Hello");
	        var xhr = new XMLHttpRequest();
	        var apiKey = "ya6sZIGXQmptSdkturD1l3391gYfRG6K"; 
	        var url = "http://www.mapquestapi.com/geocoding/v1/address?key=" +
	                  apiKey + "&location=" + encodeURIComponent(address.replace(/ /g, '+'));
	
	        xhr.open("GET", url, true); 
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4) {
	                if (xhr.status === 200) {
	                    var response = JSON.parse(xhr.responseText);
	                    var locations = response.results[0].locations;
	                    if (locations.length > 0) {
	                        var geoCodeQuality = locations[0].geocodeQualityCode;
	                        if (geoCodeQuality.startsWith("P")) {
	                            handleValidationResult("Valid");
	                        } else {
	                            handleValidationResult("Invalid");
	                        }
	                    } else {
	                        handleValidationResult("Unable to validate");
	                    }
	                } else {
	                    handleValidationResult("Error");
	                }
	            }
	        };
	        xhr.send();
	    }

        function handleValidationResult(result) {
        	
            if (result === "Valid") {
                document.querySelector("input[type='submit']").disabled = false;
            } else {
                document.querySelector("input[type='submit']").disabled = true;
                alert('Enter a valid address');
            }
        }