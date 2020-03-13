import 'dart:convert';

import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:lets_play/model/event.dart';
import 'package:lets_play/services/authentication.dart';

class EventService {
  static Future<List<Event>> getEvents() async {
    List<Event> list = List();
    final waitList = <Future<void>>[];

    var url = 'http://10.0.2.2:5103/api/event';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.get(url);
    waitList.add(http.get(url));
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List)
          .map((data) => new Event.fromJson(data))
          .toList();
      waitList.add(http.get(url));
    } else {
      print('A network error occurred');
    }
    await Future.wait(waitList);
    return list;
  }

  static void updateEvent(Event event) async {
    var url = 'http://10.0.2.2:5103/api/event/${event.id}';
    final String token = Auth.currentUser.accessToken;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String json = '{"eventStatus": ${event.status == null ? 3 : event.status},"peopleNeeded": ${event.peopleNeeded}}';
    final response = await http.put(url, headers: headers, body: json);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }
    // check the status code for the result
  }

  static Future<bool> createEvent(Event event) async {
    final String token = Auth.currentUser.accessToken;
    var url = 'http://10.0.2.2:5103/api/event';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String json = '{ "eventStartDate": "${event.startDate}",'
        ' "recurring": ${event.recurring == 0 ? null : event.recurring},'
        ' "eventStatus": 1, "description":" ${event.description}",'
        ' "peopleNeeded": ${event.peopleNeeded}, "title":" ${event.title}",'
        ' "address": "${event.exactAddress}","category":"${event.category.name}",'
        ' "parentCategoryId": ${event.category.parentId},'
        ' "city": "${event.city.name}" }';

    final response = await http.post(url, headers: headers, body: json);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print(response.request);
      print('A network error occurred');
      return false;
    }
    // check the status code for the result
  }
}
