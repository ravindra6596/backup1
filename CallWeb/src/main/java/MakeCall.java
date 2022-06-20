
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;
//import com.twilio.rest.preview.sync.service.Document;
import com.twilio.twiml.TwiMLException;
import com.twilio.twiml.VoiceResponse;
import com.twilio.twiml.voice.Hangup;
import com.twilio.type.PhoneNumber;
import com.twilio.type.Twiml;

@WebServlet("/MakeCall")
public class MakeCall extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MakeCall() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static final String ACCOUNT_SID = "AC956631d274f71453e1c8bf17bc5a9cf6";
	public static final String AUTH_TOKEN = "c66d9b8e0d8f45d4ad96644f846e3fb0";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Call
		// +918698965948
		// Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		String flag = request.getParameter("flag");
		String to = request.getParameter("to");
		String from = request.getParameter("from");
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

		if (flag.equalsIgnoreCase("CALL")) {

			
			Call call = Call.creator(new PhoneNumber(to), // To Call
					new PhoneNumber(from), // From Call
					new Twiml("<Response><Say>Hello Twilio</Say></Response>"))
					.create();
			
			System.out.println("Calling");
			response.sendRedirect("index.jsp");
		} else if (flag.equalsIgnoreCase("DISCONNECT")) {
			disconnectCall(request, response);
			System.out.println("Disconnect");
			response.sendRedirect("index.jsp");
		}

	}

	protected void makeCall(HttpServletRequest request, HttpServletResponse response) {
		String phone = request.getParameter("dialNo");

		try {

			Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

			Call call = Call.creator(new PhoneNumber(phone), // To Call
					new PhoneNumber("(432) 223-0093"), // From Call
					new URI("http://demo.twilio.com/docs/voice.xml")).create();

		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void disconnectCall(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Yes");
		Hangup hangup = new Hangup.Builder().build();
		VoiceResponse vr = new VoiceResponse.Builder().hangup(hangup).build();

		try {
			System.out.println(vr.toXml());
		} catch (TwiMLException e) {
			e.printStackTrace();
		}
	}
}
/*Execution execution = Execution.creator(
	                "FWc02fd26bd14e691701b31fa8062c3320",
	                new PhoneNumber(to),
	                new PhoneNumber(from))
	            .create();

	        System.out.println(execution.getSid());*/
