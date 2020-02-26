import 'dart:io';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/screens/profile_page_tab.dart';
import 'package:lets_play/services/authentication.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginSignupPage extends StatefulWidget {
  static const routeName = '/signup';
  final BaseAuth auth;
  final VoidCallback loginCallback;
  final User user;

  const LoginSignupPage(
      {@required this.auth, @required this.loginCallback, @required this.user});

  @override
  State<StatefulWidget> createState() => __LoginSignupPageState();
}

class __LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  String _imageUrl;
  String _name;
  File _image;

  bool _isLoginForm;
  bool _isLoading;

  bool _isUpdatePage;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = widget.user != null ? false : true;
    _isUpdatePage = widget.user != null ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lets Play"),
      ),
      //drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          if (_isLoginForm) _showLoginForm(context),
          if (!_isLoginForm) _registerForm(context),
          showCircularProgress(),
        ],
      ),
    );
  }

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/images/illuminati.png'),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    uploadPic();
  }

  Future<String> uploadPic() async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/${(_image.path)}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      setState(() {
        _imageUrl = fileUrl;
        print("Image seted");
      });
    });
    return _imageUrl;
  }

  Widget showProfilePhoto() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Color(0xff476cfb),
            child: ClipOval(
              child: new SizedBox(
                width: 180.0,
                height: 180.0,
                child: (_image != null)
                    ? Image.file(
                        _image,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 60.0),
          child: IconButton(
            icon: Icon(
              Icons.camera,
              size: 30.0,
            ),
            onPressed: () {
              getImage();
            },
          ),
        ),
      ],
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Name',
            icon: new Icon(
              Icons.perm_identity,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.isEmpty ? 'Your name can\'t be empty' : null,
        onSaved: (value) => _name = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  Widget showSecondaryButton(BuildContext context) {
    return new FlatButton(
        onPressed:(){
          taggleFormMode(context);
        },
        child: new Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
        ));
  }

  Widget taggleFormMode(BuildContext context) {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
    if (_isLoginForm) {
      return _registerForm(context);
    } else {
      return _showLoginForm(context);
    }
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLoginForm(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(context),
              showErrorMessage(),
            ],
          )),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Sign in: $userId');
        } else {
//          String url = await uploadPic();
//          print(url);
          userId =
              await widget.auth.signUp(_email, _password, _name, _imageUrl);

          print('Sign up user: $userId');
        }

        setState(() {
          _isLoginForm = true;
        });
        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        List<String> errors = e.toString().split(',');
        print("Error: " + errors[1]);
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget _registerFormButtons(BuildContext context) {
    if (!_isUpdatePage) {
      return Column(
        children: <Widget>[
          showPrimaryButton(),
          showSecondaryButton(context),
        ],
      );
    } else if (_isUpdatePage) {
      return GestureDetector(
        onTap: () {
          if (_name.isEmpty) {
            print("Event validation failed!");
            return;
          } else {
//          _createOrder(_email.text,_phoneNumber.text,_name.text,_description.text,_placeLocation);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
        child: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SAVE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _registerForm(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showProfilePhoto(),
              if (_image == null)
                Text(
                  "Please choose profile image!",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              showNameInput(),
              showEmailInput(),
              showPasswordInput(),
              _registerFormButtons(context),
              showErrorMessage(),
            ],
          )),
    );
  }
}
