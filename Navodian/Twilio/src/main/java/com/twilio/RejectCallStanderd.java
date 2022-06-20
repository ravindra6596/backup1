package com.twilio;
import com.twilio.twiml.voice.Reject;
import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.TwiMLException;
//Reject a call playing a standard not-in-service message
public class RejectCallStanderd {
	public static void main(String[] args) {
		
        Reject reject = new Reject.Builder().build();
        VoiceResponse response = new VoiceResponse.Builder().reject(reject)
            .build();

        try {
            System.out.println(response.toXml());
        } catch (TwiMLException e) {
            e.printStackTrace();
        }
    }
}
