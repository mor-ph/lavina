import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lets_play/widgets/categories.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _cIndex = 0;
  var contents;


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
        child: contents,
      ),
      bottomNavigationBar: _indexBottom(),
    );
  }

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
    currentIndex: _cIndex,
    onTap: (index) {
      setState(() {
        _cIndex = index;
        switch (_cIndex) {
          case 0:
            contents = SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CategoryWidget(),
                ],
              ),
            );
            break;
          case 1:
            contents = SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
//                  orderList(context, cookingStatus),
                ],
              ),
            );
            break;
          case 2:
            contents = SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
//                  orderList(context, newStatus),
                ],
              ),
            );
            break;
        }
      });
    },
  );
}
