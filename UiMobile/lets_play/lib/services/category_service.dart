import 'dart:convert';

import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<Category>> getCategories() async {
    List<Category> list = List();
    var url = 'http://10.0.2.2:5103/api/category';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final waitList = <Future<void>>[];

    final response = await http.get(url);
    waitList.add(http.get(url));
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List)
          .map((data) => new Category.fromJson(data))
          .toList();
    } else {
      print('A network error occurred');
    }

    await Future.wait(waitList);
    return list;
  }

  static void createCategory(Category category) async {
    List<Category> list = List();
    var url = 'http://10.0.2.2:5103/api/category';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    final waitList = <Future<void>>[];

    String json =
        '{"name": "${category.name}","parentCategoryId": ${category.parentId}}';
    final response = await http.post(url, body: json, headers: headers);
    waitList.add(http.post(url, body: json, headers: headers));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print('A network error occurred');
    }

    await Future.wait(waitList);
  }
}
