import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  String parentId;
  IconData categoryIcon;

  Category({@required this.id, @required this.name, @required this.parentId, @required this.categoryIcon});
}
