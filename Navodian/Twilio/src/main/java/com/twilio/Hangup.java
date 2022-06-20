package com.twilio;

import com.twilio.twiml.TwiMLException;
import com.twilio.twiml.VoiceResponse;

public class Hangup {
    public static void main(String[] args) {
       
    	System.out.println("Yes");
		com.twilio.twiml.voice.Hangup hangup = new com.twilio.twiml.voice.Hangup.Builder().build();
		VoiceResponse vr = new VoiceResponse.Builder().hangup(hangup).build();

		try {
			System.out.println(vr.toXml());
		} catch (TwiMLException e) {
			e.printStackTrace();
		}	
		System.out.println("Exit");
	}
}
