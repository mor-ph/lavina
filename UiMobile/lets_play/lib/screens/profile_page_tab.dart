import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/widgets/event_list.dart';

import 'login_signup_screen.dart';

class ProfilePage extends StatelessWidget {
  List<Event> eventsList = [
    Event(
        title: "Play football",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 12.toString(),
        createdByUser:
            User(uid: 1, userName: "Ivan@gmail.com", email: 'Ivan@gmail.com'),
        city: City(id: 1, name: "Plovdiv")),
    Event(
        title: "Play monopolia",
        category: Category(id: 2, name: "Board Game"),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 4.toString(),
        createdByUser: User(uid: 3, userName: "Gosho@gmail.com"),
        city: City(id: 1, name: "Plovdiv")),
    Event(
        title: "Play handball",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
        peopleNeeded: 4.toString(),
        createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
        city: City(id: 1, name: "Plovdiv")),
  ];

  User user = User(uid: 1, userName: "Vankata", email: 'Ivan@gmail.com');

  @override
  Widget build(BuildContext context) {
    List<Event> sortedEventList = eventsList
        .where((event) => event.createdByUser.uid == user.uid)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginSignupPage(user: user)),
                );
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    'assets/images/profile_image.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      user.userName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
            EventList(events: sortedEventList),
          ],
        ),
      ),
    );
  }
}
