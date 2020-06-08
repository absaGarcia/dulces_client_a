import 'package:dulces_client_a/screens/add_candy.dart';
import 'package:dulces_client_a/screens/candy_page.dart';
import 'package:dulces_client_a/screens/car_shop.dart';
import 'package:dulces_client_a/screens/login_screen.dart';
import 'package:dulces_client_a/screens/order_list.dart';
import 'package:dulces_client_a/screens/register_screen.dart';
import 'package:dulces_client_a/screens/select_place.dart';
import 'package:flutter/material.dart';

void main() => runApp(DulcesClient());

class DulcesClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        CandyPage.id: (context) => CandyPage(),
        OrderList.id: (context) => OrderList(),
        CarShop.id: (context) => CarShop(),
        SelectPlace.id: (context) => SelectPlace(),
        AddCandy.id: (context) => AddCandy(),
      },
    );
  }
}
