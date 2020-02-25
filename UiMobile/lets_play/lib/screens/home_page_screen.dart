import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
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

  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
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
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: TabBarView(
          controller: _controller,
          children: <Widget>[HomePageTab(), HomePageTab(), HomePageTab()],
        ),
      ),
      bottomNavigationBar: _tabs(),
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

  Widget _indexBottom() => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            activeIcon: Icon(
              Icons.home,
              size: 40,
              color: Colors.red,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              "New",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            activeIcon: Icon(
              Icons.add,
              size: 40,
              color: Colors.red,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.face,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            activeIcon: Icon(
              Icons.face,
              size: 40,
              color: Colors.red,
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _controller.index,
        onTap: (index) {
          _controller.animateTo(index);
        },
      );
}
