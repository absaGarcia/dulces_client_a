import 'package:firebase_database/firebase_database.dart';

class Person{

  Person(this._id,this._userProfile, this._email, this._uidAuth );

  String _id;
  String _userProfile;
  String _email;
  String _uidAuth;
  
  Person.map(dynamic obj){
    this._userProfile = obj['userProfile'];
    this._email= obj['email'];
    this._uidAuth = obj['uidAuth'];
  }

  String get id => _id;
  String get userProfile => _userProfile;
  String get email => _email;
  String get uidAuth => _uidAuth;

  Person.fromSnapShot(DataSnapshot snapshot){
    _id          = snapshot.key;
    _userProfile = snapshot.value['userProfile'];
    _email       = snapshot.value['email'];
    _uidAuth     = snapshot.value['uidAuth'];
    }
}