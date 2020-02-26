
import 'package:flutter/material.dart';
import 'package:lets_play/model/event.dart';

abstract class EventCategorisedState {}

class EventCategorUninitializedState extends EventCategorisedState {}

class EventCategoryFetchingState extends EventCategorisedState {}

class EventCategoryFetchedState extends EventCategorisedState {
  final List<Event> events;
  EventCategoryFetchedState({@required this.events});

  @override
  List<Object> get props => [events];
}

class EventCategoryErrorState extends EventCategorisedState {}

class EventCategoryEmptyState extends EventCategorisedState {
  final List<Event> events;
  EventCategoryEmptyState({@required this.events});

  @override
  List<Object> get props => [events];
}