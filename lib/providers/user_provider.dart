import 'package:firebase_storage/firebase_storage.dart';
import '../data_models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

// UserProvider erbt von ChangeNotifier, um sicherzustellen, dass bei Änderungen
// des Benutzerzustands Listeners benachrichtigt werden
class UserProvider with ChangeNotifier {
  User? _user = User();
  // Getter für den Benutzer
  User? get user => _user;

  // Setter für den Benutzer
  set user(User? value) {
    _user = value;
    // Benachrichtigung an Listeners, dass der Benutzerzustand geändert wurde
    notifyListeners();
  }

  // Methode zum Hochladen des Profilbilds des Benutzers
  Future<void> uploadProfileImage(
      File image, String? userId, String? authToken) async {
    // Pfad zum Speichern des Bilds in Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child(userId.toString() + '.jpg');

    // Hochladen des Bilds
    await ref.putFile(image).then((p0) => null);
    // Abrufen der Download-URL für das Bild
    final url = await ref.getDownloadURL();
    // Setzen der Profilbild-URL für den Benutzer
    user?.profileImageUrl = url;
    // Aktualisieren der Benutzerdaten
    updateUserData(userId, authToken);
  }

  // Methode zum Speichern der Benutzerdaten
  Future<void> setUserData(String? userId, String? authToken) async {
    // URL für den PUT-Aufruf zum Speichern der Benutzerdaten
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    // Aufruf der API zum Speichern der Benutzerdaten
    final response = await http.put(url,
        body: jsonEncode({
          'name': user?.name,
          'proficiency': user?.proficiency,
          'profileImageUrl': user?.profileImageUrl,
        }));
    if (response.statusCode >= 400) {
      // Fehler beim Aktualisieren der Benutzerdaten
    } else {
      // Erfolgreich aktualisiert
    }
  }

// Methode zum Aktualisieren der Nutzerdaten
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

// holt die Benutzerdaten ab und Aktualisiert die globalen Benutzerdaten in der App
  Future<void> fetchUserData(String? userId, String? authToken) async {
    http.Response response = await getRequest(userId, authToken);
    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      user = User.fromJson(extractedData);
      notifyListeners();
    } else {
      return;
    }
  }

// holt die daten von einem User ab
  Future<User?> getUser(String? userId, String? authToken) async {
    http.Response response = await getRequest(userId, authToken);
    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(extractedData);
    } else {
      return null;
    }
  }

// Sendet eine GET-Anfrage
  Future<http.Response> getRequest(String? userId, String? authToken) async {
    final url = Uri.parse(
        'https://museart-351c7-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    final response = await http.get(url);
    return response;
  }
}
