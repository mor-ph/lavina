import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/user.dart';

class Event {
  String id;
  String title;
  User createdByUser;
  String startDate;
  String description;
  DateTime createdAt;
  City city;
  String peopleNeeded;
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
      @required this.city,
      @required this.peopleNeeded,
      @required this.updatedAt,
      @required this.status,
      @required this.category});
}
