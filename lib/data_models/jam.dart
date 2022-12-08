class Jam {
  int id;
  String title;
  String date;
  String time;
  String location;
  String description;
  bool isPrivate;
  List<String> prefreableGenres;
  List<String> prefreableInstruments;
  Jam({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    this.isPrivate = false,
    this.description = "",
    this.prefreableGenres = const [],
    this.prefreableInstruments = const [],
  });
  void makeJamPrivate() {
    isPrivate = true;
  }
}
