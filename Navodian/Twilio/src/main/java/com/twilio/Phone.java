package com.twilio;
import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.voice.*;

import java.util.Arrays;
public class Phone {

	public static void main(String[] args) {
		

		Say say = new Say.Builder("During an active call, you can use the Dial verb to connect the current caller to another party. We’re now going to connect you to the Twilio support phone menu, which we built with these same TwiML verbs.")
			.build();

		Dial dial = new Dial.Builder("+18448144627")
			.build();

		VoiceResponse response = new VoiceResponse.Builder()
			.say(say)
			.dial(dial)
			.build();

		System.out.println(response.toXml());

	}

}
