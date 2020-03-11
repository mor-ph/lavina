import 'dart:convert';

import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:lets_play/model/event.dart';

class EventService {
  static Future<List<Event>> getEvents() async{
    List<Event> list = List();
    var urlUsers = 'http://localhost:5103/api/event/getall';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.get(urlUsers);
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List).map((data) => new Event.fromJson(data))
          .toList();
    } else {
      print('A network error occurred');
    }


    return list;
  }
}
