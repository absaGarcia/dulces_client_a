import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'car_shop_bottom.dart';


class CandyDisplay extends StatelessWidget {
  CandyDisplay({
    @required this.imageCandy,
    @required this.labelCandy,
    @required this.onPressed,
  });

  final String imageCandy;
  final String labelCandy;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.white,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.amberAccent),
                  ),
                  child: Image.asset(
                    imageCandy,
                    height: 100.0,
                    width: 150.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Text(
                '$labelCandy',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            CarShopBottom(onPressed: onPressed,),
            ],
          ),
        ],
      ),
    );
  }
}

