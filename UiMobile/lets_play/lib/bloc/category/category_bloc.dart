//import 'package:lets_play/presentation/presentation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_event.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';

import 'category_state.dart';

class CategoryBloc extends Bloc<CategorySelectedEvent, EventCategorisedState> {
  final List<Event> events;

  CategoryBloc({@required this.events}) : assert(events != null);

  @override
  EventCategorisedState get initialState => EventCategoryEmptyState(events: events);

  @override
  Stream<EventCategorisedState> mapEventToState(
      CategorySelectedEvent event) async* {
    if (event is CategorySelectedEvent) {
      yield EventCategoryFetchingState();
      try {
        final Category category = event.category;
        final List<Event> sortedListEvents =
            events.where((event) => event.category.id == category.id).toList();
        yield EventCategoryFetchedState(events: sortedListEvents, category: event.category, subCategories: event.subCategories);
      } catch (_) {
        yield EventCategoryErrorState();
      }
    }
  }
}
