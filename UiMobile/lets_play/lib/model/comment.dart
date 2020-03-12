import 'package:flutter/cupertino.dart';
import 'package:lets_play/model/user.dart';

class Comment {
  final int id;
  final User user;
  final String avatarUrl;
  final String message;
  final DateTime postedOn;
  final int eventId;

  Comment(
      {@required this.id,
      @required this.user,
      @required this.avatarUrl,
      @required this.message,
      @required this.postedOn,
      @required this.eventId});

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        user = User.fromJson(json['user'])
        /* User.fromJson(json['user']).userName*/,
        message = json['message'] as String,
        eventId = json['eventId'] as int,
        postedOn = DateTime.parse(json['postedOn']),
        avatarUrl = "assets/images/profile_image.png";
}
