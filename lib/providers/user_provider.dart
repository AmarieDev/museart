import 'package:firebase_storage/firebase_storage.dart';
import '../data_models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

class UserProvider with ChangeNotifier {
  User? _user = User();
  User? get user => _user;
  bool isFirstTime = false;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Future<void> uploadProfileImage(
      File image, String? userId, String? authToken) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(userId.toString() + '.jpg');

    await ref.putFile(image).then((p0) => null);
    final url = await ref.getDownloadURL();
    user?.profileImageUrl = url;
    updateUserData(userId, authToken);
  }

  Future<void> setUserData(String? userId, String? authToken) async {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.put(url,
        body: jsonEncode({
          'name': user?.name,
          'proficiency': user?.proficiency,
          'profileImageUrl': user?.profileImageUrl,
        }));
    if (response.statusCode >= 400) {
      // Error updating user data
      print("error 400");
    } else {
      // Update successful
      print("success");
    }
  }

  Future<void> updateUserData(String? userId, String? authToken) async {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.patch(url,
        body: jsonEncode({
          'name': user?.name,
          'proficiency': user?.proficiency,
          'profileImageUrl': user?.profileImageUrl,
        }));
    if (response.statusCode >= 400) {
      // Error updating user data
    } else {
      // Update successful

    }
  }

  Future<void> fetchUserData(String? userId, String? authToken) async {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.get(url);
    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      user = User.fromJson(extractedData);
      notifyListeners();
    } else {
      return;
    }
  }

  Future<User?> getUser(String? userId, String? authToken) async {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.get(url);
    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(extractedData);
    } else {
      return null;
    }
  }
}
