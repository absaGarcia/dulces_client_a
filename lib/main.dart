import 'package:dulces_client_a/models/candy_data.dart';
import 'package:dulces_client_a/screens/add_candy.dart';
import 'package:dulces_client_a/screens/listview_product.dart';
import 'package:dulces_client_a/screens/login_screen.dart';
import 'package:dulces_client_a/screens/orderhistory_screen.dart';

import 'package:dulces_client_a/screens/register_screen.dart';
import 'package:dulces_client_a/screens/select_place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(DulcesClient());

class DulcesClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CandyData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: LoginScreen.id,
        routes: {
          'listview_products':(context) => ListViewProducts(),
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          OrderHistory.id:(context) => OrderHistory(),
          SelectPlace.id: (context) => SelectPlace(),
          AddCandy.id: (context) => AddCandy(),
        },
      ),
    );
  }
}
