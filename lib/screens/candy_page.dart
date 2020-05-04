import 'package:flutter/material.dart';

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
        actions: <Widget>[
          IconButton(
              alignment: Alignment.bottomLeft,
              icon: const Icon(Icons.menu),
              onPressed: null),
        ],
      ),
    );
  }
}
