import 'package:flutter/material.dart';

class User {
  String uid;
  String name;
  String email;
  String phoneNumber;
  String profileImageUrl;
  String role;

  User({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.profileImageUrl,
    @required this.role});
}
