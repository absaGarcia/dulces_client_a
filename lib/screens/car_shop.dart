import 'package:flutter/material.dart';
import 'package:dulces_client_a/components/menu_lateral.dart';

class CarShop extends StatefulWidget {
  static String id = 'car_shop';
  @override
  _CarShopState createState() => _CarShopState();
}

class _CarShopState extends State<CarShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      drawer: MenuLateral(),
    );
  }
}
