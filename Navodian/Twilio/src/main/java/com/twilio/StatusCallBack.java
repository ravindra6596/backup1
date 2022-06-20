package com.twilio;

import java.net.URI;

import com.twilio.http.HttpMethod;
import com.twilio.rest.api.v2010.account.Call;
import com.twilio.type.PhoneNumber;
//Status CallBack
public class StatusCallBack {
	public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6"; 
	public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";
	public static void main(String[] args) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		Call call = Call.creator(
				new PhoneNumber(" +918698965948"),
				new PhoneNumber("(432) 223-0093"),
				URI.create("http://demo.twilio.com/docs/voice.xml"))
				.setMethod(HttpMethod.GET)
				.setStatusCallback("http://demo.twilio.com/docs/voice.xml")
				.setStatusCallbackMethod(HttpMethod.POST)
				.create();
	}
}
