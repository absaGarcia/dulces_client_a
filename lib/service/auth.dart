import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:io' show Platform;

abstract class BaseAuth  {

  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  

  Future<String> signIn(String email, String password) async {
    authProblems errorType;

    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    }catch(e){
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
          default:
            print('Case ${e.message}');
        }
      } else if (Platform.isIOS) {
          switch (e.code) {
            case 'Error 17011':
              errorType = authProblems.UserNotFound;
              break;
            case 'Error 17009':
              errorType = authProblems.PasswordNotValid;
              break;
            case 'Error 17020':
              errorType = authProblems.NetworkError;
              break;
            default:
              print('Case ${e.message}');
          }
      }
    print('The error is $errorType');
    return "error";
  }
    
  }

  Future<String> signUp(String email, String password) async {
    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    }catch(e){
      return "error";
    }
   
    
  }

  Future<FirebaseUser> getCurrentUser() async {
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