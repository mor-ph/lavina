import 'dart:convert';

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
  int recurring;

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
      @required this.exactAddress,
      @required this.recurring});

  Event.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        startDate = DateTime.parse(json['eventStartDate']),
        id = json['id'] as int,
        createdByUser = User.fromJson(json['user']),
        createdAt = DateTime.parse(json['createdOn']),
        description = json['description'] as String,
        city = City.fromJson(json['city']),
        peopleNeeded = json['peopleNeeded'] as int,
        status = json['status'],
        isActive = json['isactive'] as bool,
        category = Category.fromJson(json['category']),
        exactAddress = json['address'] as String,
        recurring = json['recurrnig'] as int;
}
