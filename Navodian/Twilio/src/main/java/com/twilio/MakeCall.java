package com.twilio;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;

import com.twilio.rest.api.v2010.account.Call;
import com.twilio.twiml.TwiMLException;
import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.voice.Hangup;
import com.twilio.type.PhoneNumber;
//Multiple Number Call
//System.getenv("TWILIO_AUTH_TOKEN");
//System.getenv("TWILIO_ACCOUNT_SID");
public class MakeCall {
	public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6"; 
	public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";
	 
	
	public static void main(String[] args) throws URISyntaxException {
		//,"+91 92844 53894"
		ArrayList<String> list = new ArrayList<String>(Arrays.asList("+918698965948"));
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		
		for(int i = 0; i < list.size(); i++) {
			if(list.size() !=1) {
				System.out.println(list.size());
			}
			//Call
			
		  Call call = Call.creator( new PhoneNumber(list.get(i)),//To Call 
		 new PhoneNumber("(432) 223-0093"),// From Call 
		 //new URI("http://demo.twilio.com/docs/voice.xml") )
		new com.twilio.type.Twiml("<Response><Say>Welocome To Twilio Tutorial!</Say></Response>"))	  
				  .create();
		  System.out.println("Calling = "+call.getSid());
		 //Message
		/*  com.twilio.rest.api.v2010.account.Message message = 
					com.twilio.rest.api.v2010.account.Message
							.creator(
							new PhoneNumber(list.get(i)), 
							new PhoneNumber("(432) 223-0093"), 
							"Welcome To RDIGS").create();
			 if(message !=null) {
				  System.out.println(message);
			  }*/
		}
		
	}
}