import 'dart:convert';

import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:lets_play/model/city.dart';

import 'package:lets_play/model/comment.dart';

class CommentService {
  static Future<List<Comment>> getComments() async {
    List<Comment> list = List();
    var url = 'http://10.0.2.2:5101/comments';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final waitList = <Future<void>>[];

    final response = await http.get(url);
    waitList.add(http.get(url));
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List)
          .map((data) => new Comment.fromJson(data))
          .toList();
    } else {
      print('A network error occurred');
    }

    await Future.wait(waitList);
    return list;
  }

  static void addComment(Comment comment) async {
    List<Comment> list = List();
    var url = 'http://10.0.2.2:5101/comments/';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final waitList = <Future<void>>[];

    String json =
        '{"id": ${comment.id},"message":${comment.message} ,"eventId": ${comment.eventId},"userId": ${comment.user.uid}}';
    final response = await http.post(url, body: json, headers: headers);
    waitList.add(http.post(url, body: json, headers: headers));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }

    await Future.wait(waitList);
  }
}
