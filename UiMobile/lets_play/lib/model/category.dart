import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/material.dart';

class Category extends BaseData {
  int id;
  String name;
  int parentId;
  IconData categoryIcon;
  bool isSelected = false;

  Category({@required this.id, @required this.name, @required this.parentId, @required this.categoryIcon, @required this.isSelected});

  @override
  Map<String, Category> getExtraData() {
    // TODO: implement getExtraData
    return {'key': this};
  }

  @override
  String getId() {
    // TODO: implement getId
    return this.id.toString();
  }

  @override
  String getParentId() {
    // TODO: implement getParentId
    return this.parentId.toString();
  }

  @override
  String getTitle() {
    // TODO: implement getTitle
    return this.name;
  }
}
