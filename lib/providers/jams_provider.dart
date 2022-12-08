import 'package:flutter/material.dart';
import 'dart:convert';
import '../data_models/jam.dart';
import 'package:http/http.dart' as http;

class JamsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Jam> _jams = [
    Jam(
      id: 1,
      title: "first jam",
      date: "05.06.2023",
      time: "15:30",
      location: "Bregenz",
      description: "let's jam!",
      isPrivate: true,
      prefreableGenres: ["Rock"],
      prefreableInstruments: ["guitar", "drums"],
    ),
    Jam(
      id: 2,
      title: " Rock and Roll",
      date: "01.02.2023",
      time: "15:30",
      location: "Bregenz",
      description: "ONlY PROS",
      isPrivate: false,
      prefreableGenres: ["Rock"],
      prefreableInstruments: ["guitar", "drums"],
    ),
    Jam(
      id: 3,
      title: "the ulti jam",
      date: "04.05.2023",
      time: "16:30",
      location: "Dornbirn",
      description: "Cool people only!",
      isPrivate: false,
      prefreableGenres: ["Metal"],
      prefreableInstruments: ["guitar", "drums"],
    ),
  ];
  //returns a copy of jams so that no modification can happen when this object gets accessed
  List<Jam> get jams {
    return [..._jams];
  }

  Jam findById(int id) {
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
            'description': value.description,
            'private': value.isPrivate,
            'prefreable genres': value.prefreableGenres,
            'prefreable insturments': value.prefreableInstruments
          }),
        )
        .then((response) {});
    _jams.add(value);
    //notify every listener that a change has happen
    notifyListeners();
  }
}
