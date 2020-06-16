import 'package:flutter/material.dart';

class CandyTile extends StatelessWidget {
  final String candyTile;
  final int priceTile;
  final int cantidad;
  final Function onPressed;
  int position;
  CandyTile(
      {this.position,
      this.candyTile,
      this.cantidad,
      this.priceTile,
      this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        candyTile,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("\$" + priceTile.toString()),
      leading: Text(cantidad.toString()),
      trailing: RawMaterialButton(
        onPressed: onPressed,
        child: Icon(Icons.shopping_cart),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        fillColor: Colors.amber,
      ),
    );
  }
}
