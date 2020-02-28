import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/user.dart';

class Event {
  int id;
  String title;
  User createdByUser;
  DateTime startDate;
  String exactAddress;
  String description;
  DateTime createdAt;
  City city;
  int peopleNeeded;
  DateTime updatedAt;
  String status;
  bool isActive;
  Category category;

  Event(
      {@required this.id,
      @required this.title,
      @required this.createdByUser,
      @required this.startDate,
      @required this.description,
      @required this.createdAt,
      @required this.city,
      @required this.peopleNeeded,
      @required this.updatedAt,
      @required this.status,
      @required this.isActive,
      @required this.category,
      @required this.exactAddress});
}
