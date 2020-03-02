import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/bloc/category/category_state.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/screens/subcategory_screen.dart';
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
                      _eventListByState(state, context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _eventListByState(state, context) {
    if (state is EventCategoryFetchedState) {
      final List<Event> events = state.events;
      return Column(
        children: <Widget>[
          SubCategory(
              subCategories: state.subCategories,
              parentCategory: state.category,
              isSubCategory: true),
          EventList(events: events)
        ],
      );
    } else if (state is EventCategoryEmptyState) {
      print("emptyState!");

      // dummy data
      List<Event> eventsList = [
        Event(
            title: "Play football",
            category: Category(id: 1, name: "Sport"),
            createdAt: DateTime.now(),
            startDate: DateTime.utc(2020, 4, 2),
            peopleNeeded: 12,
            status: "Active",
            exactAddress: 'Kichuk',
            createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
            city: City(id: 1, name: "Plovdiv")),
        Event(
            title: "Play football",
            category: Category(id: 1, name: "Sport"),
            createdAt: DateTime.now(),
            startDate: DateTime.now(),
            status: "Active",
            peopleNeeded: 4,
            createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
            city: City(id: 1, name: "Plovdiv")),
        Event(
            title: "Play handball",
            category: Category(
                id: 5,
                name: 'Handball',
                categoryIcon: Icons.category,
                parentId: 1),
            createdAt: DateTime.now(),
            startDate: DateTime.now(),
            peopleNeeded: 2,
            status: "Active",
            createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
            city: City(id: 1, name: "Banq")),
        Event(
            title: "Play monopolia",
            category: Category(
                id: 3,
                name: 'Monopolia',
                categoryIcon: Icons.directions_run,
                parentId: 1),
            createdAt: DateTime.now(),
            startDate: DateTime.now(),
            status: "Active",
            peopleNeeded: 3,
            createdByUser: User(uid: 2, userName: "GOsho@gmail.com"),
            city: City(id: 1, name: "Plovdiv")),
        Event(
            title: "Play monopolia",
            category: Category(
                id: 3,
                name: 'Monopolia',
                categoryIcon: Icons.directions_run,
                parentId: 1),
            createdAt: DateTime.now(),
            startDate: DateTime.now(),
            status: "Active",
            peopleNeeded: 3,
            createdByUser: User(uid: 2, userName: "GOsho@gmail.com"),
            city: City(id: 1, name: "Plovdiv")),
      ];

      return Column(children: <Widget>[EventList(events: eventsList)]);
    }
  }
}
