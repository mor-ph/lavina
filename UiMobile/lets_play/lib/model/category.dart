import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  int parentId;
  IconData categoryIcon;

  Category({@required this.id, @required this.name, @required this.parentId, @required this.categoryIcon});
}
