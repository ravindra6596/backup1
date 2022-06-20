

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Call;
import com.twilio.type.PhoneNumber;

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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String phone = request.getParameter("dialNo");
		System.out.println(phone);
			//Call
		  //+918698965948
		//Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
			try {Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
			System.out.println(ACCOUNT_SID+" \n "+AUTH_TOKEN);
				Call call = Call.creator( new PhoneNumber(phone),//To Call 
				 new PhoneNumber("(432) 223-0093"),// From Call 
				 new URI("http://demo.twilio.com/docs/voice.xml") ).create();
			} catch (URISyntaxException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/*com.twilio.rest.api.v2010.account.Message message = 
					com.twilio.rest.api.v2010.account.Message
					.creator(
							new PhoneNumber(phone), 
							new PhoneNumber("(432) 223-0093"), 
							"Welcome To RDIGS").create();*/
			System.out.println("Success");

}
	}
