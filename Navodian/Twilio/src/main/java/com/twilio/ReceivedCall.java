package com.twilio;
import static spark.Spark.post;

import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.voice.Say;

public class ReceivedCall {
  public static void main(String[] args) {
	post("receive-call",(req, res)-> {
		VoiceResponse twiml = new VoiceResponse.Builder()
				.say(new Say.Builder("Welcome To Twilio Tutorial Using Java Programming Language.")
				.build()).build();
	return twiml.toXml();
	});
}
 }
