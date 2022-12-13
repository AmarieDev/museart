class Jam {
  String id;
  String title;
  String date;
  String time;
  String location;
  String description;
  int maxJamers;
  bool isPrivate;
  List<dynamic> prefreableGenres;
  List<dynamic> prefreableInstruments;
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
  });
  void makeJamPrivate() {
    isPrivate = true;
  }
}
