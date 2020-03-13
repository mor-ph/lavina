import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/screens/profile_page_tab.dart';
import 'package:lets_play/services/authentication.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginSignupPage extends StatefulWidget {
  final Auth auth;
  final VoidCallback loginCallback;
  final User user;

  const LoginSignupPage(
      {@required this.auth, @required this.loginCallback, @required this.user});

  @override
  State<StatefulWidget> createState() => __LoginSignupPageState();
}

class __LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

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

    if (_isUpdatePage) {
      setState(() {
        _nameController.text = widget.user.userName;
        _emailController.text = widget.user.email;
      });
    }
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
          if (!_isLoginForm)
            _registerForm(context),
          // _showCircularProgress(),
        ],
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  Widget _showLogo() {
    return Hero(
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

  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    _uploadPic();
  }

  Future<String> _uploadPic() async {
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

  Widget _showProfilePhoto() {
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
              _getImageFromGallery();
            },
          ),
        ),
      ],
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: _emailController,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _emailController.text = value.trim(),
      ),
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: _nameController,
        decoration: new InputDecoration(
            hintText: 'Name',
            icon: new Icon(
              Icons.perm_identity,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.isEmpty ? 'Your name can\'t be empty' : null,
        onSaved: (value) => _nameController.text = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        controller: _passwordController,
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

  Widget _showPrimaryButton() {
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

  Widget _showSecondaryButton(BuildContext context) {
    return new FlatButton(
        onPressed: () {
          _taggleFormMode(context);
        },
        child: new Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
        ));
  }

  Widget _taggleFormMode(BuildContext context) {
    _resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
    if (_isLoginForm) {
      return _registerForm(context);
    } else {
      return _showLoginForm(context);
    }
  }

  Widget _showErrorMessage() {
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
              _showLogo(),
              _showNameInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(context),
              _showErrorMessage(),
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
          userId = await widget.auth.signIn(_nameController.text, _password);
          print('Sign in: $userId');
        } else {
          userId = await widget.auth.signUp(_emailController.text, _password,
              _nameController.text, _imageUrl);

          _password = null;
          print('Sign up user: $userId');
        }

        setState(() {
          _isLoginForm = true;
        });
        if (userId.length > 0 && userId != null && _isLoginForm) {
          print("Widget callback");
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
    SnackBar snackBar;
    if (!_isUpdatePage) {
      return Column(
        children: <Widget>[
          _showPrimaryButton(),
          _showSecondaryButton(context),
        ],
      );
    } else if (_isUpdatePage) {
      Flushbar flushbar;

      return GestureDetector(
        onTap: () {
          if (_nameController.text.isEmpty ||
              _emailController.text.isEmpty ||
              _passwordController.text.isEmpty) {
            flushbar = Flushbar(
              duration: Duration(seconds: 30),
              message: 'Validation fail, please fill all fields',
            )..show(context);
            
            return;
          } else {
//            _createUser(_email.text,_);
            Auth.updateProfile(userName: _nameController.text, password: _passwordController.text, email: _emailController.text);
            flushbar = Flushbar(
              duration: Duration(seconds: 30),
              message: 'User profile updated successfully',
            )..show(context);
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
              _showProfilePhoto(),
              if (_image == null)
                Text(
                  "Please choose profile image!",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              _showNameInput(),
              _showEmailInput(),
              _showPasswordInput(),
              _registerFormButtons(context),
              _showErrorMessage(),
            ],
          )),
    );
  }
}
