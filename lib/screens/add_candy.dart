import 'package:flutter/material.dart';

class AddCandy extends StatefulWidget {
  static String id = 'add_candy';
  @override
  _AddCandyState createState() => _AddCandyState();
}

class _AddCandyState extends State<AddCandy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text('Cantidad'),
          ],
        ),
      ),
    );
  }
}
