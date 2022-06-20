import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  String baseAPIurl = "https://dev.croitresoftwares.com/nls/api";
  //String baseAPIurl = "http://c73426cf6b12.ngrok.io/api";

  SharedPreferences sharedPreferences;

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Future<Map<String, dynamic>> checkIfLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token == null) return null;

    var obj = parseJwt(token);
    int currTime = DateTime.now().millisecondsSinceEpoch;

    if (currTime >= (obj["exp"] * 1000)) {
      return null;
    } else {
      return {"token": token, "empid": sharedPreferences.getInt('userid')};
    }
  }
}
