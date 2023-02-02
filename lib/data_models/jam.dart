import 'package:flutter_application/data_models/jam_location.dart';

// Klasse "Jam" definiert ein Jam-Ereignis mit allen notwendigen Eigenschaften.
class Jam {
  // ID des Jam-Ereignisses.
  String id;
  // Titel des Jam-Ereignisses.
  String title;
  // Datum des Jam-Ereignisses.
  String date;
  // Zeitpunkt des Jam-Ereignisses.
  String time;
  // Host des Jam-Ereignisses.
  String host;
  // Standort des Jam-Ereignisses.
  JamLocation location;
  // Beschreibung des Jam-Ereignisses.
  String description;
  // Maximale Anzahl der Teilnehmer.
  int maxJamers;
  // Gibt an, ob das Jam-Ereignis privat ist.
  bool isPrivate;
  // Bevorzugte Genres für das Jam-Ereignis.
  List<dynamic> prefreableGenres;
  // Bevorzugte Instrumente für das Jam-Ereignis.
  List<dynamic> prefreableInstruments;
  // Liste der beigetretenen Benutzer.
  List<dynamic> joinedUsers = [''];
  // Konstruktor für die Klasse "Jam".
  Jam({
    // Pflichtfelder.
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.host,
    required this.maxJamers,
    // Optionale Felder mit Standardwerten.
    this.isPrivate = false,
    this.description = "",
    this.prefreableGenres = const [],
    this.prefreableInstruments = const [],
    this.joinedUsers = const [],
  });
}
