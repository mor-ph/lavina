import 'package:flutter/foundation.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';

class UserEvent {
  int id;
  User user;
  Event event;

  UserEvent({@required this.id, @required this.user, @required this.event});

  UserEvent.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        user = User.fromJson(json['user']),
        event = json['event'] == null ? Event.fromJson(json['event']) : null;
}
