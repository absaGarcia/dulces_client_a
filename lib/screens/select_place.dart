import 'package:dulces_client_a/components/side_bar.dart';
import 'package:flutter/material.dart';

class SelectPlace extends StatefulWidget {
  static String id = 'select_place';
  @override
  _SelectPlaceState createState() => _SelectPlaceState();
}

class _SelectPlaceState extends State<SelectPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicacion Actual'),
      ),
      drawer: SideBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'images/mapa.png',
                  height: 200.0,
                ),
              ],
            ),
            Row(
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }
}
