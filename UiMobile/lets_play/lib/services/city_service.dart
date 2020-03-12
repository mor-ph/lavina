import 'dart:convert';

import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:lets_play/model/city.dart';

class CityService {
  static Future<List<City>> getCities() async {
    List<City> list = List();
    var url = 'http://10.0.2.2:5103/api/location';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final waitList = <Future<void>>[];

    final response = await http.get(url);
    waitList.add(http.get(url));
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List)
          .map((data) => new City.fromJson(data))
          .toList();
    } else {
      print('A network error occurred');
    }

    await Future.wait(waitList);
    return list;
  }
}
