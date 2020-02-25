import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_play/model/event.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  EventDetails({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: _eventDetails(),
    );
  }

  Widget _eventDetails() {
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
                    event.createdByUser.userName,
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
                      event.location.address,
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
                      event.startDate,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      size: 35,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      event.peopleNeeded.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                descriptionBox(event),
                Divider(height: 5,color: Colors.black,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionBox(Event event) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 100),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(event.description == null ? "Description" : event.description , style: TextStyle(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic,),),
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
