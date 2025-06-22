import 'dart:convert';

class UserModel {
  final String firstName;
  final String? lastName;
  final String email;
  final String dateOfJoin;
  final String userId;
  final bool isPinchecked;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfJoin,
    required this.isPinchecked
  });

  Map<String, dynamic> toMap() => {
    "firstName": firstName,
    "lastName": lastName ?? "",
    "email": email,
    "dateOfJoin": dateOfJoin,
    "userId":userId,
    "isPinChecked":isPinchecked
  };

  factory UserModel.fromMap(Map<String, dynamic> userMap) => UserModel(
    userId: userMap['userId'],
    firstName: userMap["firstName"],
    lastName: userMap["lastName"],
    email: userMap["email"],
    dateOfJoin: userMap["dateOfJoin"],
    isPinchecked: userMap['isPinChecked']
  );

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String srcJson) =>
      UserModel.fromMap(json.decode(srcJson));
}
