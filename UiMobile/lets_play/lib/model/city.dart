import 'package:flutter/material.dart';

class City {
  int id;
  String name;

  City({@required this.id,@required this.name});

  City.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        id =json['id'] as int;
}
