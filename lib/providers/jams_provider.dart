import 'package:flutter/material.dart';
import 'package:flutter_application/data_models/PlaceLocation.dart';
import 'dart:convert';
import '../data_models/jam.dart';
import 'package:http/http.dart' as http;

class JamsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Jam> _jams = [];
  //returns a copy of jams so that no modification can happen when this object gets accessed
  List<Jam> get jams {
    return [..._jams];
  }

  final String? authToken;
  final String? _currentUser;

  JamsProvider(this.authToken, this._currentUser, this._jams);

  Jam findById(String id) {
    return _jams.firstWhere((element) => element.id == id);
  }

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
      joinUnjoinJam(newJam.id);
      _jams.add(newJam);
      //notify every listener that a change has happen
      notifyListeners();
    });
  }

  Future<void> joinUnjoinJam(String jamId) async {
    final url = Uri.parse(
        "https://museart-351c7-default-rtdb.firebaseio.com/jams/$jamId.json?auth=$authToken");
    final getResponse = await http.get(url);
    final element = json.decode(getResponse.body);
    if (element["joined users"] == null) {
      List<dynamic> list = ['_currentUser'];
      final update = {"joined users": list};
      var response = await http.patch(url, body: json.encode(update));
      return;
    }
    List<dynamic> list = List<String>.from(element["joined users"]);
    if (!await hasAlreadyJoined(jamId)) {
      list.add(_currentUser);
      final update = {"joined users": list};
      var response = await http.patch(url, body: json.encode(update));
      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}');
        return;
      }
    } else {
      list.remove(_currentUser);
      final update = {"joined users": list};
      var response = await http.patch(url, body: json.encode(update));
      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}');
        return;
      }
    }
  }

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
              location: PlaceLocation(
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
      throw (error);
    }
  }
}
