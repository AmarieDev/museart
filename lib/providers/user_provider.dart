import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../data_models/user.dart';

class UserProvider with ChangeNotifier {
  User _currentUser = User();
  String? userName;
  String? currentUserId;
  String? authToken;
  User? get currentUser => _currentUser;

  Future<String> getUserName() async {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$currentUserId/user_name.json?auth=$authToken');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON response
      return json.decode(response.body);
    } else {
      return json.decode(response.body).toString();
      //throw Exception('Failed to get value');
    }
  }

  setUserName(String? userName) {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$currentUserId/user_name.json?auth=$authToken');
    http.put(url, body: json.encode(userName));
    _currentUser.userName = userName;
    notifyListeners();
  }
}
