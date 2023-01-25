import 'package:provider/provider.dart';

import '../data_models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'auth_provider.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  Future<void> setUserData(String userId) async {
    final url = Uri.parse(
        'https://your-firebase-app.firebaseio.com/users/$userId.json');
    final response = await http.put(url,
        body: jsonEncode({
          'name': user.name,
          'proficiency': user.proficiency,
          'profileImageUrl': user.profileImageUrl,
        }));
    if (response.statusCode >= 400) {
      // Error updating user data
    } else {
      // Update successful

    }
  }

  Future<void> updateUserData(String userId) async {
    final url = Uri.parse(
        'https://your-firebase-app.firebaseio.com/users/$userId.json');
    final response = await http.patch(url,
        body: jsonEncode({
          'name': user.name,
          'proficiency': user.proficiency,
          'profileImageUrl': user.profileImageUrl,
        }));
    if (response.statusCode >= 400) {
      // Error updating user data
    } else {
      // Update successful

    }
  }

  Future<void> fetchUserData(String userId) async {
    final url = Uri.parse(
        'https://your-firebase-app.firebaseio.com/users/$userId.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    user = User.fromJson(extractedData);
    notifyListeners();
  }
}
