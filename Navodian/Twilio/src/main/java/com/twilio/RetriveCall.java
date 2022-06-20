package com.twilio;

//Install the Java helper library from twilio.com/docs/java/install

import com.twilio.Twilio;
import com.twilio.base.ResourceSet;
import com.twilio.rest.api.v2010.account.Call;

public class RetriveCall {
	// Find your Account Sid and Token at twilio.com/console
	// and set the environment variables. See http://twil.io/secure
	public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6";
	public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";

	public static void main(String[] args) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		ResourceSet<Call> calls = Call.reader()
//				.limit(20)
				.read();

		for (Call record : calls) {
			System.out.println("Caller Name:="+record.getAnsweredBy());
			System.out.println(record.getSid());
			System.out.println(record.getFrom());
			System.out.println(record.getStatus()+"\n Time \t\t"+record.getStartTime());
		}
	}
}
