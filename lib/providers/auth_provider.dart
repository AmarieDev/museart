import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import '../http_exception.dart';

// Klasse für die Authentifizierung
class AuthProvider with ChangeNotifier {
  String? _token; // Token für die Authentifizierung
  DateTime? _expiryDate; // Ablaufdatum des Tokens
  String? _userId; // ID des Benutzers
  Timer? _authTimer; // Timer für das automatische Abmelden

  // Gibt die aktuelle Benutzer-ID zurück
  String? getCurrentUserId() {
    return _userId;
  }

// Authentifizierungsprozess
  Future<void> auth(String email, String password, String urlSegment) async {
    // URL für die Authentifizierungsanfrage
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA6LKfa-j9at9EfjcxPLGaypjPe5PLDJZc');
    try {
      // Sende Anfrage an den Server
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
      // Verarbeite Antwort vom Server
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        // Wirf Exception, wenn Fehlermeldung vom Server empfangen wurde
        throw HttpException(responseData['error']['message']);
      }
      // Speichere Authentifizierungsdaten
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      // Starte Timer für das automatische Abmelden
      _autLogout();
      // Informiere Abhängige Widgets über Änderungen
      notifyListeners();
      // Speichere Authentifizierungsdaten auf dem Gerät
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  // Getter, der überprüft, ob der Benutzer angemeldet ist
  bool get isAuth {
    return token != null;
  }

  // Getter, der den Token zurückgibt, falls er gültig ist
  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Methode, die den Benutzer registriert
  Future<void> signup(String email, String password) async {
    return auth(email, password, "signUp");
  }

  // Methode, die den Benutzer anmeldet
  Future<void> signin(String email, String password) async {
    return auth(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    // Abfrage ob es "userData" in den SharedPreferences gibt
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    // Extrahiere die gespeicherte "userData" aus den SharedPreferences
    final extractedUserData = prefs.getString('userData');
    // Dekodiere die "userData" zu einem Map-Objekt
    final userData = json.decode(extractedUserData!) as Map<String, dynamic>;
    // Parse das Ablaufdatum aus den "userData"
    final expiryDate = DateTime.parse(userData['expiryDate']);
    // Überprüfe ob das Ablaufdatum in der Vergangenheit liegt
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    // Setze die Membervariablen mit den Daten aus den "userData"
    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;
    // Informiere alle zuhörer über die neue Zustand
    notifyListeners();
    // Starte den automatischen Logout-Timer
    _autLogout();
    return true;
  }

  Future<void> logout() async {
    // Setze alle Membervariablen zurück
    _token = null;
    _userId = null;
    _expiryDate = null;
    // Stoppe den aktuellen Logout-Timer falls vorhanden
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    // Informiere alle zuhörer über die neue Zustand
    notifyListeners();
    // Lösche die gespeicherte "userData" aus den SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autLogout() {
    // Stoppe den aktuellen Logout-Timer falls vorhanden
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    // Berechne die verbleibende Zeit bis zum Ablaufdatum
    final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    // Starte einen neuen Logout-Timer mit der berechneten Zeit
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }
}
