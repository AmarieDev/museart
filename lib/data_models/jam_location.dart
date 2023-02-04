// Klasse JamLocation definiert eine Location für ein Musikevent
class JamLocation {
  // Attribut "lat" speichert die Breitengrad-Koordinate
  final double lat;

  // Attribut "lng" speichert die Längengrad-Koordinate
  final double lng;

  // Attribut "address" speichert die Adresse als String (optional)
  final String? address;

  // Konstruktor JamLocation nimmt die Breiten- und Längengrad-Koordinaten sowie die Adresse entgegen
  const JamLocation({
    // Pflichtfeld: Breitengrad-Koordinate
    required this.lat,

    // Pflichtfeld: Längengrad-Koordinate
    required this.lng,

    // Optional: Adresse
    this.address,
  });
}
