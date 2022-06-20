package com.controller.object;

import java.util.Date;
import java.util.Random;
import java.util.*;

public class EncryptDecrypt {
	private static Random rand = new Random((new Date()).getTime());

	public static void main(String[] args) throws Exception {

		String st = "admin123";

		String enc = encrypt(st);

		System.out.println("Encrypted string :" + enc);

		System.out.println("Decrypted string :" + decrypt(enc));

	}

	public static String encrypt(String str) {

		Base64.Encoder encoder = Base64.getEncoder();

		byte[] salt = new byte[8];

		rand.nextBytes(salt);
		byte[] salt_encode = encoder.encode(salt);
		byte[] str_encode = encoder.encode(str.getBytes());

		String Str_final = new String(salt_encode) + new String(str_encode);
		return Str_final;
	}

	public static String decrypt(String encstr) {

		Base64.Decoder decoder = Base64.getDecoder();
		
		String str_decode = null;
		if (encstr.length() > 12) {

			String cipher = encstr.substring(12);

			

			str_decode = new String(decoder.decode(cipher));

		}
		else {
			str_decode=  new String(decoder.decode(encstr));
		}
		return str_decode;
	}
}