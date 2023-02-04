import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/jam_location.dart';
import 'dart:convert';
import '../data_models/jam.dart';
import 'package:http/http.dart' as http;

// Provider-Klasse, die die Daten von Jams an die Widgets liefert.
// Enthält auch Methoden zur Interaktion mit den Daten, z.B. Jams hinzufügen, abrufen und aktualisieren
class JamsProvider with ChangeNotifier {
  // Jams Liste
  List<Jam> _jams = [];

  // Kopie von Jams, die nicht von anderen Klassen geändert werden können
  List<Jam> get jams {
    return [..._jams];
  }

  // Variablen zum Speichern des Authentifizierungstokens und des aktuellen Benutzers
  final String? authToken;
  final String? _currentUser;

  // Constructor to initialize values
  JamsProvider(this.authToken, this._currentUser, this._jams);

  // Findet einen Jam anhand seiner ID
  Jam findById(String id) {
    return _jams.firstWhere((element) => element.id == id);
  }

  // Fügt einen neuen Jam zur Datenbank hinzu
  void addJam(Jam value) {
    final url = Uri.parse(
        "https://museart-351c7-default-rtdb.firebaseio.com/jams.json?auth=$authToken");
    http
        .post(
      url,
      body: json.encode({
        'title': value.title,
        'date': value.date,
        'time': value.time,
        'host': value.host,
        'address': value.location.address,
        'lat': value.location.lat,
        'lng': value.location.lng,
        'max jamers': value.maxJamers,
        'description': value.description,
        'private': value.isPrivate,
        'prefreable genres': value.prefreableGenres,
        'prefreable instruments': value.prefreableInstruments,
        'joined users': value.joinedUsers,
      }),
    )
        .then((response) {
      final newJam = Jam(
        id: json.decode(response.body)['name'],
        title: value.title,
        date: value.date,
        time: value.time,
        host: value.host,
        location: value.location,
        maxJamers: value.maxJamers,
        description: value.description,
        isPrivate: value.isPrivate,
        prefreableGenres: value.prefreableGenres,
        prefreableInstruments: value.prefreableInstruments,
        joinedUsers: value.joinedUsers,
      );
      // Dem neuen Jam beitreten
      joinUnjoinJam(newJam.id);
      _jams.add(newJam);
      // Informiere Abhängige Widgets über Änderungen
      notifyListeners();
    });
  }

  // Je nach aktuellem Status dem Jam beitreten oder aus dem Jam austreten
  Future<void> joinUnjoinJam(String jamId) async {
    final url = Uri.parse(
        "https://museart-351c7-default-rtdb.firebaseio.com/jams/$jamId.json?auth=$authToken");
    final getResponse = await http.get(url);
    final element = json.decode(getResponse.body);
    if (element["joined users"] == null) {
      List<dynamic> list = [];
      final update = {"joined users": list};
      await http.patch(url, body: json.encode(update));
      return;
    }
    List<dynamic> list = List<String>.from(element["joined users"]);
    if (!await hasAlreadyJoined(jamId)) {
      list.add(_currentUser);
      final update = {"joined users": list};
      var response = await http.patch(url, body: json.encode(update));
      if (response.statusCode != 200) {
        //  print('Error: ${response.statusCode}');
        return;
      }
    } else {
      list.remove(_currentUser);
      final update = {"joined users": list};
      var response = await http.patch(url, body: json.encode(update));
      if (response.statusCode != 200) {
        //  print('Error: ${response.statusCode}');
        return;
      }
    }
  }

//überprüfe, ob der Benutzer schon beigetreten ist
  Future<bool> hasAlreadyJoined(String jamId) async {
    final url = Uri.parse(
        "https://museart-351c7-default-rtdb.firebaseio.com/jams/$jamId.json?auth=$authToken");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var joinedUsers = data['joined users'];
      if (joinedUsers != null && joinedUsers.contains(_currentUser)) {
        return true;
      }
    }

    return false;
  }

// hollt die Jams vom Datenbank ab
  Future<void> fetchJams() async {
    final url = Uri.parse(
        "https://museart-351c7-default-rtdb.firebaseio.com/jams.json?auth=$authToken");
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400 || response.body == "null") {
        return;
        // Error updating user data
      } else {
        // Update successful

        final fetchedData = json.decode(response.body) as Map<String, dynamic>;
        final List<Jam> loadedJams = [];
        fetchedData.forEach((key, value) {
          loadedJams.add(
            Jam(
              id: key,
              title: value['title'],
              date: value['date'],
              time: value['time'],
              host: value['host'],
              location: JamLocation(
                  lat: value['lat'],
                  lng: value['lng'],
                  address: value['adderss']),
              maxJamers: value['max jamers'],
              description: value['description'],
              isPrivate: value['private'],
              prefreableGenres: value['prefreable genres'],
              prefreableInstruments: value['prefreable instruments'],
              joinedUsers: value['joined users'],
            ),
          );
        });
        _jams = loadedJams;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }
}
