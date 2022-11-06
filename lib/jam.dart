class Jam {
  String title;
  String date;
  String time;
  String location;
  String? description;
  bool isPrivate = false;
  List<String?>? prefreableGenres;
  List<String>? prefreableInstruments;
  Jam({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    this.description,
    this.prefreableGenres,
    this.prefreableInstruments,
  });
  void makeJamPrivate() {
    isPrivate = true;
  }
}
