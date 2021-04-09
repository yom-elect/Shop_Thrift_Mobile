import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class AuthService {
  Future _authenticate(String email, String password, String urlType) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlType?key=AIzaSyBkYcrGrIG0_OzSMr-3PYOhDX_vBdmThmA";
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      return responseData;
    } catch (err) {
      throw err;
    }
  }

  Future signup(String email, String password) async {
    try {
      return _authenticate(email, password, 'signUp');
    } catch (err) {
      throw err;
    }
  }

  Future login(String email, String password) async {
    try {
      return _authenticate(email, password, 'signInWithPassword');
    } catch (err) {
      throw err;
    }
  }
}
