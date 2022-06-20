package com.twilio;


import static spark.Spark.*;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.twiml.voice.Say;
import com.twilio.twiml.VoiceResponse;
import com.twilio.exception.ApiException;
import com.twilio.type.PhoneNumber;


public class SayCall {
    public static void main(String[] args) {
        port(8080);
        post("/answer", (req, res) -> {
            // get the urlencoded form parameters
            String caller = req.queryParams("(432) 223-0093");
            String twilioNumber = req.queryParams("+918698965948");

            sendSms(caller, twilioNumber);
            VoiceResponse twiml = new VoiceResponse.Builder()
                .say(new Say.Builder("Thanks for calling! We just sent you a text with a clue.")
                      .voice(Say.Voice.ALICE)
                      .build())
                .build();

            return twiml.toXml();
        });
    }

    public static void sendSms(String toNumber, String fromNumber) {
    	 String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6"; 
    	 String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";

        try {
            Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
            Message
                .creator(new PhoneNumber(toNumber),
                         new PhoneNumber(fromNumber),
                        "There's always money in the banana stand.")
                .create();
        } catch (ApiException e) {
            if (e.getCode() == 21614) {
                System.out.println("Uh oh, looks like this caller can't receive SMS messages.");
            }
        }
    }
}


