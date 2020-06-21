import 'package:firebase_database/firebase_database.dart';

class Order{

  Order(this._id, this._name, this._cuantity, this._username, this._place, this._total);

  String _id;
  String _name;
  String _cuantity;
  String _username;
  String _place;
  String _total;
  
  Order.map(dynamic obj){
    this._name     = obj['name'];
    this._cuantity = obj['cuantity'];
    this._username = obj['userName'];
    this._place    = obj['place'];
    this._total    = obj['total'];
  }
  String get id => _id;
  String get name => _name;
  String get userName => _username;
  String get cuantity => _cuantity;
  String get place => _place;
  String get total => _total;

  Order.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _cuantity = snapshot.value['cuantity'];
    _username = snapshot.value['userName'];
    _place = snapshot.value['place'];
    _total = snapshot.value['total'];
  }
}