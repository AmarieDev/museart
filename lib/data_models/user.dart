class User {
  // Name des Users
  String? name;
  // Welches Instrument der User spielt
  String? proficiency;
  // URL des Profilbilds des Users
  String? profileImageUrl;

  // Konstruktor, um eine Instanz von User mit Werten für Namen, Kompetenz und Profilbild zu erstellen
  User({this.name, this.proficiency, this.profileImageUrl});

  // Methode zur Erstellung einer neuen Instanz von User mit möglicher Überschreibung einiger Membervariablen
  User copyWith({String? name, String? proficiency, String? profileImageUrl}) {
    // Gibt eine neue Instanz von User zurück, mit übergebenen oder aktuellen Werten für Namen, Kompetenz und Profilbild
    return User(
      name: name ?? this.name,
      proficiency: proficiency ?? this.proficiency,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  // Fabrikmethode, um eine Instanz von User aus einem JSON-Objekt zu erstellen
  factory User.fromJson(Map<String, dynamic> json) {
    // Gibt eine neue Instanz von User zurück, mit Werten aus dem übergebenen JSON-Objekt
    return User(
      name: json['name'],
      proficiency: json['proficiency'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
