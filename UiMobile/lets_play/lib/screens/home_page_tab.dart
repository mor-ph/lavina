import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/bloc/category/category_state.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';

class HomePageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<CategoryBloc>(context),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Home page"),
            ),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CategoryWidget(),
                      getEventListByState(state, context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget getEventListByState(state, context) {
    if (state is EventCategoryFetchedState) {
      final List<Event> events = state.events;
      return EventList(events: events);
    } else if (state is EventCategoryEmptyState) {
      return Column(
        children: <Widget>[
          Text(
            'No events added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              )),
        ],
      );
    }
  }
}
