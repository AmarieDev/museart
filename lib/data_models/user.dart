import 'jam.dart';

class User {
  final String id;
  String firstName;
  String lastName;
  String birthday;
  final UserCredentials _userCredentials = UserCredentials();
  List<String> prefreableGenres;
  List<String> instruments;
  List<Jam> jams;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    this.prefreableGenres = const [],
    this.instruments = const [],
    this.jams = const [],
  });
  void setEmail(String newValue) {
    _userCredentials.email = newValue;
  }

  void setPassword(String newValue) {
    _userCredentials.password = newValue;
  }
}

class UserCredentials {
  late String email;
  late String password;
}
