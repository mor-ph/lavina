import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/location.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/screens/event_details_screen.dart';

class EventList extends StatelessWidget {
  final List<Event> events;

  const EventList({this.events});

  @override
  Widget build(BuildContext context) {
//    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
//    Category category = categoryBloc.selectedCategory;
//    List<Event> sortedList = events.where((event) => event.category.id == category.id).toList();
    return events.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No products added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          )
        : ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children:
                events.map((data) => _buildEventItem(data, context)).toList(),
          );
  }

  Widget _buildEventItem(Event event, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetails(event: event)),
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 5,
        ),
        child: ListTile(
          leading: ClipOval(
            child: Image.asset(
              'assets/images/profile_image.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(event.title),
          subtitle: Text(event.createdByUser.userName),
          trailing: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.place),
                  SizedBox(
                    width: 5,
                  ),
                  Text(event.location.address),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 5,
                  ),
                  Text(event.startDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
