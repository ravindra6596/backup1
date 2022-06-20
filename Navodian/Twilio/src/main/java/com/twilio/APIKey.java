package com.twilio;

import com.twilio.base.ResourceSet;
import com.twilio.rest.api.v2010.account.Key;
import com.twilio.rest.api.v2010.account.NewKey;

public class APIKey {
	public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6";
	public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";

	public static void main(String[] args) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		NewKey newKey = NewKey.creator().create();
        NewKey nameKey = NewKey.creator().setFriendlyName("User Joey").create();

		System.out.println("API Key =  "+newKey.getSid());
		System.out.println("Name API Key =  "+nameKey.getSid());
		System.out.println("--- Resource Set---");
        ResourceSet<Key> keys = Key.reader().limit(20).read();
        int i = 1;
        
        for(Key record : keys) {
            System.out.println(i++ +" -> "+record.getSid());
        }
     }
}
