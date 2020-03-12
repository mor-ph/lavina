import 'dart:convert';

import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user_event.dart';

class UserEventService {
  static Future<List<UserEvent>> getUserEvents() async {
    List<UserEvent> list = List();
    var url = 'http://10.0.2.2:5103/api/event/userevents';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final waitList = <Future<void>>[];

    final response = await http.get(url);
    waitList.add(http.get(url));
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List)
          .map((data) => new UserEvent.fromJson(data))
          .toList();
    } else {
      print('A network error occurred');
    }

    await Future.wait(waitList);
    return list;
  }

  static void createUserEvent(UserEvent userEvent) async {
    var url = 'http://10.0.2.2:5103/api/event/userevent';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String json =
        '{"userid":${userEvent.user.uid} ,"eventid": ${userEvent.event.id}';
    final response = await http.post(url, headers: headers, body: json);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }
  }
}
