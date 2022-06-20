package com.twilio;

import com.twilio.twiml.TwiMLException;
import com.twilio.twiml.VoiceResponse;


public class Play {
    public static void main(String[] args) {
       
        com.twilio.twiml.voice.Play play = new com.twilio.twiml.voice.Play.Builder("https://api.twilio.com/cowbell.mp3").loop(2).build();
        VoiceResponse response = new VoiceResponse.Builder().play(play).build();

        try {
            System.out.println(response.toXml());
        } catch (TwiMLException e) {
            e.printStackTrace();
        }
    }
}
