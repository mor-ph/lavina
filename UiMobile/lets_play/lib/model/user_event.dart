import 'package:flutter/foundation.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';

class UserEvent {
  int id;
  User user;
  Event event;

  UserEvent({this.id,@required this.user,@required this.event});


}