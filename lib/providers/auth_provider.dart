import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/widgets.dart';
import '../http_exception.dart';

class AuthProvider with ChangeNotifier {
  var _token;
  var _expiryDate;
  var _userId;

  Future<void> auth(String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA6LKfa-j9at9EfjcxPLGaypjPe5PLDJZc');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password) async {
    return auth(email, password, "signUp");
  }

  Future<void> signin(String email, String password) async {
    return auth(email, password, "signInWithPassword");
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
