import 'dart:convert';

import 'package:equatable/equatable.dart';

UserData UserFromJson(String str) => UserData.fromJson(json.decode(str));

String UserToJson(UserData data) => json.encode(data.toJson());

class UserData extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String phoneNumber;

  UserData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, firstname, lastname, username, email, phoneNumber];

   
  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"], 
    firstname: json["firstname"] ?? "", 
    lastname: json["lastname"] ?? "", 
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}