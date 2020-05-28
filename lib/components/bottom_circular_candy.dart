import 'package:flutter/material.dart';

class BottomCircularCandy extends StatelessWidget {
  BottomCircularCandy({@required this.icon, @required this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: 36.0,
        height: 36.0,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.black,
      ),
      shape: CircleBorder(),
      fillColor: Colors.amber,
    );
  }
}
