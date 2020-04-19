import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/model/user_event.dart';
import 'package:lets_play/services/authentication.dart';
import 'package:lets_play/services/event_service.dart';
import 'package:lets_play/services/userevents_service.dart';
import 'package:lets_play/widgets/event_list.dart';
import 'package:lets_play/widgets/progress_indicator.dart';

import 'login_signup_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _controller;
  List<UserEvent> _allUserEvents;


  List<Event> _eventsList;

  getEvents() async {
    List<Event> events = await EventService.getEvents();
    if (events != null) {
      setState(() {
        _eventsList = events;
      });
    }
  }

  getUserEvents() async {
    List<UserEvent> userEvents = await UserEventService.getUserEvents();
    if (userEvents != null) {
      setState(() {
        _allUserEvents = userEvents;
      });
    }
  }

  User _user;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    setState(() {
      _user = Auth.currentUser;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_allUserEvents == null) {
      getUserEvents();
      getEvents();
      return ProgressIndicatorWidget();
    }
    List<Event> createdEvents = _eventsList
        .where((event) => event.createdByUser.uid == _user.uid)
        .toList();
    List<UserEvent> userEvents = _allUserEvents
        .where((userEvent) =>
    userEvent.user.uid == _user.uid &&
        _user.uid != userEvent.event.createdByUser.uid)
        .toList();
    List<Event> joinedEvents =
    userEvents.map((userEvents) => userEvents.event).toList();
    if (_eventsList == null) {
      getEvents();

      return ProgressIndicatorWidget();
    }
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/lavina-logo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Lavina'))
            ],
          ),
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
                          builder: (context) => LoginSignupPage(user: _user)),
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
                      color: Theme.of(context).buttonColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        _user.userName,
                        style: TextStyle(

                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        _user.email,
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

  Widget _profileTabs() =>
      TabBar(
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
