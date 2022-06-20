package com.twilio;

import com.twilio.Twilio;

import com.twilio.type.PhoneNumber;

public class Message {
	public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6";
	public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";

	public static void main(String[] args) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		com.twilio.rest.api.v2010.account.Message message = 
				com.twilio.rest.api.v2010.account.Message
				.creator(
						new PhoneNumber("+918698965948"), 
						new PhoneNumber("(432) 223-0093"), 
						"Welcome To RDIGS").create();
	}

}
