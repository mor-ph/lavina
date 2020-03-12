import 'dart:convert';

import 'package:lets_play/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
    static Future<List<Category>> getCategories() async{
      List<Category> list = List();
      var urlUsers = 'http://localhost:5103/api/category';
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.get(urlUsers);
      if (response.statusCode == 200) {
        print(response.body);
        list = (json.decode(response.body) as List).map((data) => new Category.fromJson(data))
            .toList();
      } else {
        print('A network error occurred');
      }


      return list;
    }
}
