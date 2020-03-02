import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/model/user_event.dart';
import 'package:lets_play/widgets/event_list.dart';

import 'login_signup_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _controller;

  //dummy data
  List<UserEvent> allUserEvents = [
    UserEvent(
        event: Event(
            title: "Play football",
            category: Category(id: 1, name: "Sport"),
            createdAt: DateTime.now(),
            startDate: DateTime.utc(2020, 4, 2),
            peopleNeeded: 12,
            createdByUser: User(
                uid: 1, userName: "Ivan@gmail.com", email: 'Ivan@gmail.com'),
            city: City(id: 1, name: "Plovdiv")),
        user:
            User(uid: 1, userName: "Ivan@gmail.com", email: 'Ivan@gmail.com')),
    UserEvent(
        event: Event(
            title: "Play football",
            category: Category(id: 1, name: "Sport"),
            createdAt: DateTime.now(),
            startDate: DateTime.utc(2020, 4, 2),
            peopleNeeded: 12,
            createdByUser:
                User(uid: 3, userName: "Pesho", email: 'Ivan@gmail.com'),
            city: City(id: 1, name: "Plovdiv")),
        user:
            User(uid: 1, userName: "Ivan@gmail.com", email: 'Ivan@gmail.com')),
  ];

  List<Event> eventsList = [
    Event(
        title: "Play football",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateTime.utc(2020, 4, 2),
        peopleNeeded: 12,
        createdByUser:
            User(uid: 1, userName: "Ivan@gmail.com", email: 'Ivan@gmail.com'),
        city: City(id: 1, name: "Plovdiv")),
    Event(
        title: "Play monopolia",
        category: Category(id: 2, name: "Board Game"),
        createdAt: DateTime.now(),
        startDate: DateTime.now(),
        peopleNeeded: 4,
        createdByUser: User(uid: 3, userName: "Gosho@gmail.com"),
        city: City(id: 1, name: "Plovdiv")),
    Event(
        title: "Play handball",
        category: Category(id: 1, name: "Sport"),
        createdAt: DateTime.now(),
        startDate: DateTime.now(),
        peopleNeeded: 4,
        createdByUser: User(uid: 1, userName: "Ivan@gmail.com"),
        city: City(id: 1, name: "Plovdiv")),
  ];

  User user = User(uid: 1, userName: "Vankata", email: 'Ivan@gmail.com');

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Event> createdEvents = eventsList
        .where((event) => event.createdByUser.uid == user.uid)
        .toList();
    List<UserEvent> userEvents = allUserEvents
        .where((userEvent) =>
            userEvent.user.uid == user.uid &&
            user.uid != userEvent.event.createdByUser.uid)
        .toList();
    List<Event> joinedEvents =
        userEvents.map((userEvents) => userEvents.event).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("My profile"),
          bottom: _profileTabs(),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginSignupPage(user: user)),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.edit),
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 0.5,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _userEvents(),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  EventList(events: createdEvents),
                  EventList(events: joinedEvents)
                ],
                dragStartBehavior: DragStartBehavior.down,
              ),
            ),
          ],
        ));
  }

  Widget _userEvents() {
    return Padding(
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
            ]));
  }

  Widget _profileTabs() => TabBar(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        controller: _controller,
        tabs: <Widget>[
          Tab(
            icon: Icon(
              Icons.folder_shared,
              size: 30,
              color: Colors.white,
            ),
            text: "Created",
          ),
          Tab(
            icon: Icon(
              Icons.directions_run,
              size: 30,
              color: Colors.white,
            ),
            text: "Joined",
          ),
        ],
      );
}
