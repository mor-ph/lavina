import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/location.dart';
import 'package:lets_play/model/user.dart';

class Event {
  String id;
  String title;
  User createdByUser;
  String startDate;
  String description;
  DateTime createdAt;
  Location location;
  int peopleNeeded;
  DateTime updatedAt;
  String status;
  Category category;

  Event(
      {@required this.id,
      @required this.title,
      @required this.createdByUser,
      @required this.startDate,
      @required this.description,
      @required this.createdAt,
      @required this.location,
      @required this.peopleNeeded,
      @required this.updatedAt,
      @required this.status,
      @required this.category});
}
