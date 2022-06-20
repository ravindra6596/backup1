package com.twilio;

//Install the Java helper library from twilio.com/docs/java/install

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;

public class Terminate {
 // Find your Account Sid and Token at twilio.com/console
 // DANGER! This is insecure. See http://twil.io/secure
 public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6";
 public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";

 public static void main(String[] args) {
	 System.out.println(ACCOUNT_SID);
     Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
     System.out.println(AUTH_TOKEN);
     Call call = Call.updater("CAa57f2c940f826985244dbd6227ddba6d")
         .setStatus(Call.UpdateStatus.COMPLETED).update();
     System.out.println("Below Call\n"+call);
     System.out.println(call.getPhoneNumberSid());
     System.out.println(call.getTo());
 }
}
