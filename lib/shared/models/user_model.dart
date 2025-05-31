import 'dart:convert';

class UserModel {
  final String firstName;
  final String? lastName;
  final String email;
  final String dateOfJoin;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfJoin,
  });

  Map<String, dynamic> toMap() => {
    "firstName": firstName,
    "lastName": lastName ?? "",
    "email": email,
    "dateOfJoin": dateOfJoin,
  };

  factory UserModel.fromMap(Map<String, dynamic> userMap) => UserModel(
    firstName: userMap["firstName"],
    lastName: userMap["lastName"],
    email: userMap["email"],
    dateOfJoin: userMap["dateOfJoin"],
  );

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String srcJson) =>
      UserModel.fromMap(json.decode(srcJson));
}
