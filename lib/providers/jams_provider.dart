import 'package:flutter/material.dart';
import '../data_models/jam.dart';

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
    _jams.add(value);
    //notify every listener that a change has happen
    notifyListeners();
  }
}
