import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/location.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';

import 'home_page_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _cIndex = 0;
  Category chosenCategory = Category(id: 1);
  CategoryBloc _categoryBloc;

  TabController _controller;
  List<Event> eventsList = [
    Event(
        title: "Play football",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 12,
        createdByUser: User(userName: "Ivan@gmail.com"),
        location: Location(address: "Plovdiv")),
    Event(
        title: "Play football",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 4,
        createdByUser: User(userName: "Ivan@gmail.com"),
        location: Location(address: "Plovdiv")),
    Event(
        title: "Play handball",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 2,
        createdByUser: User(userName: "Ivan@gmail.com"),
        location: Location(address: "Banq")),
    Event(
        title: "Play monopolia",
        category: Category(
            id: 3,
            name: 'Monopolia',
            categoryIcon: Icons.directions_run,
            parentId: 1),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 3,
        createdByUser: User(userName: "Ivan@gmail.com"),
        location: Location(address: "Plovdiv")),
    Event(
        title: "Play monopolia",
        category: Category(
            id: 5,
            name: 'Monopolia',
            categoryIcon: Icons.directions_run,
            parentId: 3),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 3,
        createdByUser: User(userName: "Ivan@gmail.com"),
        location: Location(address: "Plovdiv")),
  ];

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
    _categoryBloc = CategoryBloc(events: eventsList);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Lets Play - Home page',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
    );
    return BlocProvider(
      create: (BuildContext context) => _categoryBloc,
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: TabBarView(
            controller: _controller,
            children: <Widget>[HomePageTab(), HomePageTab(), HomePageTab()],
          ),
        ),
        bottomNavigationBar: _tabs(),
      ),
    );
  }

  Widget _tabs() => TabBar(
        unselectedLabelColor: Colors.black,
        labelColor: Colors.red,
        indicatorColor: Colors.red,
        controller: _controller,
        tabs: <Widget>[
          Tab(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.black,
            ),
            text: "Home",
          ),
          Tab(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
            text: "New",
          ),
          Tab(
            icon: Icon(
              Icons.face,
              size: 30,
              color: Colors.black,
            ),
            text: "Profile",
          )
        ],
      );
}
