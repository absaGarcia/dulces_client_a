import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dulces_client_a/components/menu_lateral.dart';
import 'package:dulces_client_a/components/candy_display.dart';
import 'package:dulces_client_a/components/bottom_circular_candy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_candy.dart';

class CandyPage extends StatefulWidget {
  static String id = 'candy_page';
  @override
  _CandyPageState createState() => _CandyPageState();
}

class _CandyPageState extends State<CandyPage> {
  @override
  Widget build(BuildContext context) {
     int cantidad=1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dulces AG'),
      ),
      drawer: MenuLateral(),
      body: Padding(
        padding: EdgeInsets.zero,
        child: ListView(
          children: <Widget>[
            CandyDisplay(
              imageCandy: 'images/kitkat.png',
              labelCandy: 'KitKat',
              onPressed: (){
                setState(() {
                  Navigator.pushNamed(context, AddCandy.id);
                });
              },
            ),
            CandyDisplay(
              imageCandy: 'images/nestle.png',
              labelCandy: 'Crunch',
              onPressed: (){},
            ),
            CandyDisplay(
              imageCandy: 'images/kinderdelice.png',
              labelCandy: 'Kinder Delice',
              onPressed: (){},
            ),
            CandyDisplay(
              imageCandy: 'images/kinderbueno.png',
              labelCandy: 'Kinder Bueno',
              onPressed: (){},
            ),
            CandyDisplay(
              imageCandy: 'images/kindermaxi.png',
              labelCandy: 'Barra Kinder',
              onPressed: (){},
            ),
            CandyDisplay(
              imageCandy: 'images/snickers.png',
              labelCandy: 'Snickers',
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
