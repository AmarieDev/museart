import 'package:flutter_application/data_models/PlaceLocation.dart';

class Jam {
  String id;
  String title;
  String date;
  String time;
  PlaceLocation location;
  String description;
  int maxJamers;
  bool isPrivate;
  List<dynamic> prefreableGenres;
  List<dynamic> prefreableInstruments;
  List<dynamic>? joinedUsers = [];
  Jam({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.maxJamers,
    this.isPrivate = false,
    this.description = "",
    this.prefreableGenres = const [],
    this.prefreableInstruments = const [],
    this.joinedUsers = const [],
  });
  void makeJamPrivate() {
    isPrivate = true;
  }
}
