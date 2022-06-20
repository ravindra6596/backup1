package com.controller.object;

import org.json.JSONException;
import org.json.JSONObject;

public class SessionObject {

	String uname1 = null;
	String usertype = null;
	
	public static String session_admin(String uname, String usertype) throws Exception {
		
		if(uname == null || usertype == null || uname.equalsIgnoreCase("") || usertype.equals("")) {
			return "false";
		}
		else if(usertype.equalsIgnoreCase("admin")){
			return "true";
		}else {
			return "false";
		}
		
	}
	
public static String session_tm(String uname, String usertype) throws Exception {
		String result = null;
		if(uname == null || usertype == null || uname.equalsIgnoreCase("") || usertype.equals("")) {
			result = "false";
		}
		else if(usertype.equalsIgnoreCase("tm")){
			result = "tm";
		}else if(usertype.equalsIgnoreCase("abm")) {
			result = "abm";
		}else if(usertype.equalsIgnoreCase("rbm")) {
			result = "rbm";
		}else if(usertype.equalsIgnoreCase("bu")) {
			result = "bu";
		}else {
			result = "false";
		}
		return result;
	}

	public static JSONObject testArray(String[] testInput) throws JSONException {
		int [] ids = {12,23,332,12};
		JSONObject jsobj = new JSONObject();
		jsobj.put("name", testInput);
		jsobj.put("ids", ids );
		return jsobj;
	}

}
