import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/model/user_event.dart';
import 'package:lets_play/screens/new_event_tab.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  EventDetails({@required this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  User user = User(uid: 1, userName: "Vankata", email: 'Ivan@gmail.com');

  List<UserEvent> userEvents;

  joinToEvent(User user, context) {
    bool userAlreadyExist =
        userEvents.any((userEvent) => userEvent.user.userName == user.userName);
    if (!userAlreadyExist) {
      setState(() {
        widget.event.peopleNeeded--;
      });
      userEvents.add(new UserEvent(event: this.widget.event, user: this.user));
    } else {
      final snackbar = SnackBar(
        content: Text("You are already joined to this event!"),
        duration: Duration(milliseconds: 900),
      );

      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void initState() {
    userEvents = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.event.title,
          textAlign: TextAlign.center,
        ),
        actions: user.uid == widget.event.createdByUser.uid ?
            <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        widget.event.isActive=false;
                      });

                      //update request to BE
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.close),
                        Text(
                          "Finish",
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
            ] : <Widget>[]
      ),
      body: Builder(builder: (context) => _eventDetailsWidget(context)),
    );
  }

  Widget _eventDetailsWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
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
                    widget.event.createdByUser.userName,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Text(widget.event.status)
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      size: 35,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.event.city.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 35,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(widget.event.startDate),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.person_add,
                        size: 35,
                      ),
                      onPressed: () => joinToEvent(user, context),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.event.peopleNeeded.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                _descriptionBox(widget.event),
                Divider(
                  height: 5,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionBox(Event event) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          event.description == null ? "Description" : event.description,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: new Border(
            left: new BorderSide(),
            right: new BorderSide(),
            top: new BorderSide(),
            bottom: new BorderSide(),
          )),
    );
  }
}
