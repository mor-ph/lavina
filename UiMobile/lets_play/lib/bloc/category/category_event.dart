import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/screens/subcategory_screen.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategorySelectedEvent extends CategoryEvent{
  final Category category;
  final List<Category> subCategories;

  const CategorySelectedEvent({@required this.category, @required this.subCategories}) : assert(category!=null);

  @override
  List<Object> get props => [category];
}
