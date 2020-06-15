import 'package:dulces_client_a/models/candy_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/candy_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddCandy extends StatefulWidget {
  static String id = 'add_candy';
  @override
  _AddCandyState createState() => _AddCandyState();
}

class _AddCandyState extends State<AddCandy> {
  int newcantidad = 0;
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Container(
  
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Cantidad',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.amberAccent,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (newcantidad >= 0) {
                        newcantidad++;
                      }
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.black,
                  ),
                  shape: CircleBorder(),
                  color: Colors.amberAccent,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '$newcantidad',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 34.0,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (newcantidad > 0) {
                        newcantidad--;
                      }
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.minus,
                    color: Colors.black,
                  ),
                  shape: CircleBorder(),
                  color: Colors.amberAccent,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              child: Text(
                'Agregar',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Colors.amberAccent,
              onPressed: () {
                print(newcantidad.toString());
                Provider.of<CandyData>(context)
                    .changeCuantity(newcantidad, index);          
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
