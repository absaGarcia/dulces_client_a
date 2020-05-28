import 'package:flutter/material.dart';

class CarShopBottom extends StatelessWidget {
 CarShopBottom({@required this.onPressed});

  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(Icons.shopping_cart),
     shape:  RoundedRectangleBorder(
       borderRadius:  BorderRadius.circular(20.0),
     ),
      fillColor: Colors.amber,
    );
  }
}
