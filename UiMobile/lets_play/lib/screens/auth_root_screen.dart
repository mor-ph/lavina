import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/services/authentication.dart';

import 'login_signup_screen.dart';
import '../main.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  String _userRole = "";
  User currentUser;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      if (!this.mounted) {
        print("return!");
        return;
      }
      setState(() {
        if (user != null) {
//          FireBaseAPI.firestoreInstance
//              .collection("User")
//              .where('Uid', isEqualTo: _userId)
//              .getDocuments()
//              .then((QuerySnapshot snapshot) {
//            snapshot.documents.forEach((doc) {
//              setState(() {
//                currentUser = new User(
//                  uid: '${doc.data['Uid']}',
//                  name: '${doc.data['Name']}',
//                  email: '${doc.data['Email']}',
//                  phoneNumber: '${doc.data['PhoneNumber']}',
//                  profileImageUrl: '${doc.data['ProfileImageUrl']}',
//                  role: '${doc.data['Role']}',
//                );
//              });
//              print("User " + currentUser.name + " Role " + currentUser.role);
//
//              setState(() {
//                _userRole = '${doc.data['Role']}';
//              });
//            });
//          });
//          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: new Auth(),
          loginCallback: loginCallback,
        );
      case AuthStatus.LOGGED_IN:
        //todo
        break;
      default:
        return _buildWaitingScreen();
    }
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    print('login callback');
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    if (authStatus == AuthStatus.NOT_LOGGED_IN) {
      _userId = "";
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginSignupPage(
                auth: widget.auth,
                loginCallback: loginCallback,
              )));
      return;
    }
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }
}
