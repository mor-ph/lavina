import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password, String name, String phoneNumber, String imageUrl);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth{
  static const routeName = '/';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async{
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password,String name, String phoneNumber, String imageUrl) async {
    print('Create User');
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

   // FireBaseAPI.storeNewUser(result.user, name, phoneNumber, imageUrl);
    FirebaseUser user = result.user;

    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}