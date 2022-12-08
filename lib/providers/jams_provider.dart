import 'package:flutter/material.dart';
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

  Jam findById(String id) {
    return _jams.firstWhere((element) => element.id == id);
  }

  void addJam(Jam value) {
    final url = Uri.parse(
        "https://museart-351c7-default-rtdb.firebaseio.com/jams.json");
    http
        .post(
      url,
      body: json.encode({
        'title': value.title,
        'date': value.date,
        'time': value.time,
        'location': value.location,
        'max jamers': value.maxJamers,
        'description': value.description,
        'private': value.isPrivate,
        'prefreable genres': value.prefreableGenres,
        'prefreable instruments': value.prefreableInstruments
      }),
    )
        .then((response) {
      final newJam = Jam(
        id: json.decode(response.body)['name'],
        title: value.title,
        date: value.date,
        time: value.time,
        location: value.location,
        maxJamers: value.maxJamers,
        description: value.description,
        isPrivate: value.isPrivate,
        prefreableGenres: value.prefreableGenres,
        prefreableInstruments: value.prefreableInstruments,
      );
      _jams.add(newJam);
      //notify every listener that a change has happen
      notifyListeners();
    });
  }
}
