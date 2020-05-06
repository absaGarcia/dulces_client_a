import 'package:flutter/material.dart';
import 'package:dulces_client_a/components/menu_lateral.dart';

class CandyPage extends StatefulWidget {
  static String id = 'candy_page';
  @override
  _CandyPageState createState() => _CandyPageState();
}

class _CandyPageState extends State<CandyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dulces AG'),
      ),
      drawer: MenuLateral(),
    );
  }
}
