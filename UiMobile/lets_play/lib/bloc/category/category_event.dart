import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategorySelectedEvent extends CategoryEvent{
  final Category category;

  const CategorySelectedEvent({@required this.category}) : assert(category!=null);

  @override
  List<Object> get props => [category];
}
