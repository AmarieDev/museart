import 'jam.dart';

class User {
  String? name;
  String? proficiency;
  String? profileImageUrl;

  User({this.name, this.proficiency, this.profileImageUrl});

  User copyWith({String? name, String? proficiency, String? profileImageUrl}) {
    return User(
      name: name ?? this.name,
      proficiency: proficiency ?? this.proficiency,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

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
