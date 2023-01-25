import 'jam.dart';

class User {
  final String? name;
  final String? proficiency;
  final String? profileImageUrl;

  User({this.name, this.proficiency, this.profileImageUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      proficiency: json['proficiency'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}

class UserCredentials {
  late String email;
  late String password;
}
