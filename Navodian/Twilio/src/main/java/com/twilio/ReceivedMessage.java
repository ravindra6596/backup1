package com.twilio;

/*import static spark.Spark.post;

import com.twilio.twiml.MessagingResponse;
import com.twilio.twiml.messaging.Body;

public class ReceivedMessage {
	
	public static void main(String[] args) {
		System.out.println("Received Message");
		post("/received-sms", (req, res) -> {
			com.twilio.twiml.messaging.Message sms = new com.twilio.twiml.messaging.Message.Builder()
					.body(new Body("JH")).build();
			MessagingResponse response = new MessagingResponse.Builder().message(sms).build();
			return response.toXml();
		});
	}
}*/

import com.twilio.twiml.MessagingResponse;
import com.twilio.twiml.messaging.Body;
import com.twilio.twiml.messaging.Message;

import static spark.Spark.*;

public class ReceivedMessage {
    public static void main(String[] args) {
        get("/", (req, res) -> "Hello Web");

        post("/sms", (req, res) -> {
            res.type("application/xml");
            Body body = new Body
                    .Builder("The Robots are coming! Head for the hills!")
                    .build();
            Message sms = new Message
                    .Builder()
                    .body(body)
                    .build();
            MessagingResponse twiml = new MessagingResponse
                    .Builder()
                    .message(sms)
                    .build();
            System.out.println(body);
            return twiml.toXml();
        });
    }
}
