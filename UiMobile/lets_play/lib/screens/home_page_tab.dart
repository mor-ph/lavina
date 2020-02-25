import 'package:flutter/material.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';

class HomePageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//                  SizedBox(height: 5,)
          CategoryWidget(),
          EventList(),
        ],
      ),
    );
  }
}
