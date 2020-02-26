import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/bloc/category/category_state.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/location.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';

class HomePageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CategoryBloc>(context),
      builder: (context, state) {
        if (state is EventCategoryFetchedState) {
          final List<Event> events = state.events;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CategoryWidget(),
                EventList(events: events),
              ],
            ),
          );
        } else if (state is EventCategoryEmptyState) {
          final List<Event> events = state.events;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CategoryWidget(),
                EventList(events: events),
              ],
            ),
          );
        }
      },
    );
  }
}
