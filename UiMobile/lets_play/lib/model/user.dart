import 'package:flutter/material.dart';

class User {
  int uid;
  String userName;
  String email;
  String profileImageUrl;
  String role;

  User({
    @required this.uid,
    @required this.userName,
    @required this.email,
    @required this.profileImageUrl,
    @required this.role});
}
