package com.twilio;

import static spark.Spark.get;
import static spark.Spark.post;
import static spark.Spark.port;
import static spark.Spark.staticFileLocation;
import static spark.Spark.afterAfter;

import java.util.HashMap;

import com.github.javafaker.Faker;
import com.google.gson.Gson;

// Token generation imports
import com.twilio.jwt.accesstoken.AccessToken;
import com.twilio.jwt.accesstoken.VoiceGrant;

// TwiML generation imports
import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.voice.Dial;
import com.twilio.twiml.voice.Number;
import com.twilio.twiml.voice.Client;
import com.twilio.twiml.voice.Say;

public class Webapp {
    
    public static String generateIdentity() {
        // Create a Faker instance to generate a random username for the connecting user
        Faker faker = new Faker();
        return faker.name().firstName() + faker.address().zipCode();
    }

    public static String createJsonAccessToken(String identity) {
        String acctSid = "AC956631d274f71453e1c8bf17bc5a9cf6"; //System.getenv("TWILIO_ACCOUNT_SID");
        String applicationSid = "c66d9b8e0d8f45d4ad96644f846e3fb0";//System.getenv("TWILIO_TWIML_APP_SID");
        String apiKey = "SK748cd713af019cfd1cbf2474e230bfc8";//System.getenv("SK748cd713af019cfd1cbf2474e230bfc8");
        String apiSecret = "tplvPIfoJvxqaITJ2hOf7puIdByH07z1";//System.getenv("tplvPIfoJvxqaITJ2hOf7puIdByH07z1");
        // Create Voice grant
        VoiceGrant grant = new VoiceGrant();
        grant.setOutgoingApplicationSid(applicationSid);
        
        // Optional: add to allow incoming calls
        grant.setIncomingAllow(true);
        
        // Create access token
        AccessToken accessToken = new AccessToken.Builder(acctSid, apiKey, apiSecret)
                .identity(identity)
                .grant(grant)
                .build();
        
        String token = accessToken.toJwt();
        
        // create JSON response payload
        HashMap<String, String> json = new HashMap<String, String>();
        json.put("identity", identity);
        json.put("token", token);

        Gson gson = new Gson();
        return gson.toJson(json);
    }

    private static boolean isPhoneNumber(String to) {
        return to.matches("^[\\d\\+\\-\\(\\) ]+$");
    }

    private static Dial.Builder addChildReceiver(Dial.Builder builder, String to) {
        // wrap the phone number or client name in the appropriate TwiML verb
        // by checking if the number given has only digits and format symbols
        if (Webapp.isPhoneNumber(to)) {
            return builder.number(new Number.Builder(to).build());
        }
        return builder.client(new Client.Builder(to).build());
    }
    
    public static String createVoiceResponse(String to) {
        VoiceResponse voiceTwimlResponse;
        
        if (to != null) {
            Dial.Builder dialBuilder = new Dial.Builder()
                    .callerId(System.getenv("TWILIO_CALLER_ID"));

            Dial.Builder dialBuilderWithReceiver = Webapp.addChildReceiver(dialBuilder, to);

            voiceTwimlResponse = new VoiceResponse.Builder()
                    .dial(dialBuilderWithReceiver.build())
                    .build();
        } else {
            voiceTwimlResponse = new VoiceResponse.Builder()
                    .say(new Say.Builder("Thanks for calling!").build())
                    .build();
        }

        return voiceTwimlResponse.toXml();
    }

    public static void main(String[] args) {
        // Default port 8080
        port(8080);

        // Serve static files from src/main/resources/public
        staticFileLocation("/public");

        // Log all requests and responses
        afterAfter(new LoggingFilter());

        // Create a capability token using our Twilio credentials
        get("/token", "application/json", (request, response) -> {
            // Generate a random username for the connecting client
            String identity = Webapp.generateIdentity();

            // Render JSON response
            response.header("Content-Type", "application/json");
            return Webapp.createJsonAccessToken(identity);
        });

        // Generate voice TwiML
        post("/voice", "application/x-www-form-urlencoded", (request, response) -> {
            String to = request.queryParams("To");

            response.header("Content-Type", "text/xml");
            return Webapp.createVoiceResponse(to);
        });
    }
}
