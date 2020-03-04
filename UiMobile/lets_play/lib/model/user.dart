import 'package:flutter/material.dart';

class User {
  int uid;
  String userName;
  String email;
  String profileImageUrl;
  String role;
  String accessToken;

  User(
      {@required this.uid,
      @required this.userName,
      @required this.email,
      @required this.profileImageUrl,
      @required this.role,
      @required this.accessToken});

  User.fromJson(Map<String, dynamic> json)
      : userName = json['username'] as String,
        accessToken = json['accessToken'] as String,
        email = json['email'] as String,
        uid = json['id'] as int;
}
