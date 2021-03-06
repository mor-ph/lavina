import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lets_play/model/user.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(
      String email, String password, String name, String imageUrl);

  //Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth {
  static const routeName = '/';

  //todo need to put in local store like sqllite
  static User currentUser;
  static String accessToken;

  Future<String> signIn(String userName, String password) async {
    var urlUsers = 'http://10.0.2.2:8081/auth/login';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String json = '{"username": "$userName", "password": "$password"}';
    var response = await http.post(
      urlUsers,
      body: json,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }

    User user = parseUser(response.body);
    currentUser = user;

    return currentUser.uid.toString();
  }

  Future<String> signUp(
      String email, String password, String userName, String imageUrl) async {
    print('Create User');
    var urlUsers = 'http://10.0.2.2:8081/auth/users';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String json =
        '{"username": "$userName", "password": "$password", "email": "$email"}';
    var response = await http.post(
      urlUsers,
      body: json,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('A network error occurred');
    }
    User user = parseUser(response.body);
    currentUser = user;
    print(user);
    return currentUser.uid.toString();
  }

  User parseUser(String responseBody) {
    final parsed = json.decode(responseBody);

    return User.fromJson(parsed);
  }

  Future<User> getCurrentUser() async {
    return currentUser;
  }

//
  Future<void> signOut() async {
    currentUser = null;
    accessToken = null;
  }

  static Future<bool> updateProfile(
      {@required String userName,
      @required String password,
      @required String email}) async {
     Auth.currentUser.userName = userName;
     Auth.currentUser.email = email;

     var urlUsers = 'http://10.0.2.2:8081/auth/users/${currentUser.uid}';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Auth.currentUser.accessToken}'
    };
    String json =
        '{"username": "$userName", "password": "$password", "email": "$email"}';
    var response = await http.put(
      urlUsers,
      body: json,
      headers: headers,
    );
    if (response.statusCode == 200 && response.statusCode == 204) {
      print(response.body);
      return true;
    } else {
      print('A network error occurred');
      return false;
    }
  }
//
//  Future<void> sendEmailVerification() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
//    user.sendEmailVerification();
//  }
//
//  Future<bool> isEmailVerified() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
//    return user.isEmailVerified;
//  }
}
