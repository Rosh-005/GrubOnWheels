package actions;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class SendNotification {
	
	public String sendNotification(String name, String phone, String restaurant) {
		Message message = null;
		try {
		String accountSid = "ACc6a4321030e90f2e58078b2f87553de4";
        String authToken = "e8f3b39e0b5d875d5e0383ae2b74d9a0";

        // Initialize Twilio
        Twilio.init(accountSid, authToken);

        
        String recipientPhoneNumber = phone;

        
        String twilioPhoneNumber = "+447862137356";

        // Message content
        String messageBody = "Hi " + name + "! You have a message from " + restaurant + " on Grub On Wheels!!!";

        // Send SMS
        message = Message.creator(
                new PhoneNumber(recipientPhoneNumber),
                new PhoneNumber(twilioPhoneNumber),
                messageBody
        ).create();
        // Output the message SID to confirm the message was sent
        System.out.println("Message SID: " + message.getSid());
        
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return message.getSid();
	}

    public static void main(String[] args) {
        
        //String messageSid = sendNotification("", "");
    }
}
