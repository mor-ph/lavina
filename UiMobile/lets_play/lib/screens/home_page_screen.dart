import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/screens/profile_page_tab.dart';
import 'package:lets_play/services/event_service.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';
import 'package:lets_play/widgets/progress_indicator.dart';

import 'home_page_tab.dart';
import 'new_event_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _cIndex = 0;
  CategoryBloc _categoryBloc;

  TabController _controller;
  List<Event> _events;

  //dummy data
//  List<Event> eventsList = [
//    Event(
//        title: "Play football",
//        category: Category(id: 1, name: "Sport"),
//        createdAt: DateTime.now(),
//        startDate: DateTime.utc(2020, 4, 2),
//        status: "Active",
//        peopleNeeded: 12,
//        exactAddress: 'Kichuk',
//        createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
//        city: City(id: 1, name: "Plovdiv")),
//    Event(
//        title: "Play football",
//        category: Category(id: 1, name: "Sport"),
//        createdAt: DateTime.now(),
//        startDate: DateTime.now(),
//        status: "Active",
//        peopleNeeded: 4,
//        createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
//        city: City(id: 1, name: "Plovdiv")),
//    Event(
//        title: "Play handball",
//        category: Category(
//            id: 5, name: 'Handball', categoryIcon: Icons.category, parentId: 1),
//        createdAt: DateTime.now(),
//        startDate: DateTime.now(),
//        status: "Active",
//        peopleNeeded: 2,
//        createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
//        city: City(id: 1, name: "Banq")),
//    Event(
//        title: "Play monopolia",
//        category: Category(
//            id: 3,
//            name: 'Monopolia',
//            categoryIcon: Icons.directions_run,
//            parentId: 1),
//        createdAt: DateTime.now(),
//        startDate: DateTime.now(),
//        status: "Active",
//        peopleNeeded: 3,
//        createdByUser: User(uid: 2, userName: "GOsho@gmail.com"),
//        city: City(id: 1, name: "Plovdiv")),
//    Event(
//        title: "Play monopolia",
//        category: Category(
//            id: 3,
//            name: 'Monopolia',
//            categoryIcon: Icons.directions_run,
//            parentId: 3),
//        createdAt: DateTime.now(),
//        startDate: DateTime.now(),
//        status: "Active",
//        peopleNeeded: 3,
//        createdByUser: User(uid: 2, userName: "GOsho@gmail.com"),
//        city: City(id: 1, name: "Plovdiv")),
//  ];

  getEvents() async {
    List<Event> events = await EventService.getEvents();
    if(events != null){
      setState(() {
        _events = events;
        _categoryBloc = CategoryBloc(events: _events);
      });
    }
  }

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
    print("s");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_events == null){
      getEvents();
      return ProgressIndicatorWidget();
    }
    return BlocProvider(
      create: (BuildContext context) => _categoryBloc,
      child: Scaffold(
        body: Container(
          child: TabBarView(
            controller: _controller,
            children: <Widget>[HomePageTab(), NewEventPage(), ProfilePage()],
          ),
        ),
        bottomNavigationBar: _tabs(),
      ),
    );
  }

  Widget _tabs() => TabBar(
        unselectedLabelColor: Theme.of(context).buttonColor,
        labelColor: Colors.red[900],
        indicatorColor:  Colors.red[900],
        controller: _controller,
        tabs: <Widget>[
          Tab(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Theme.of(context).buttonColor,
            ),
            text: "Home",
          ),
          Tab(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).buttonColor,
            ),
            text: "New",
          ),
          Tab(
            icon: Icon(
              Icons.face,
              size: 30,
              color: Theme.of(context).buttonColor,
            ),
            text: "Profile",
          )
        ],
      );
}
