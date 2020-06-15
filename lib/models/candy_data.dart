import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'candy.dart';

class CandyData extends ChangeNotifier {
  List<Candy> candy = [
    Candy(name: 'KitKat', price: 20, cantidad: 0),
    Candy(name: 'Crunch', price: 16, cantidad: 0),
    Candy(name: 'Kinder Delice', price: 13, cantidad: 0),
  ];
  UnmodifiableListView<Candy> get candys {
    return UnmodifiableListView(candy);
  }

  int get candyCount {
    return candy.length;
  }

  void changeCuantity(int newcantidad, int index) {
    candy[index].cantidad = newcantidad;
    notifyListeners();
  }
 
}
