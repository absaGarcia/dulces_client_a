import 'dart:async';
import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../objects/order.dart';
import '../theme.dart' as Theme;

class OrderHistory extends StatefulWidget with NavigationStates {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}
final productReference = FirebaseDatabase.instance.reference().child('order');
class _OrderHistoryState extends State<OrderHistory> {
   List<Order> items;
 
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangeSubscription;

  int get position => null;
  @override
  void initState() {
    super.initState();
    items = new List();
    
    _onProductAddedSubscription =
        productReference.onChildAdded.listen(_onProductAdded);
    _onProductChangeSubscription =
        productReference.onChildChanged.listen(_onProductUpdate);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Theme.CompanyColors.black[100],
          primaryColor: Theme.CompanyColors.black[200],
        ),
      title: 'Pedidos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pedidos'),
          centerTitle: true,
        ),
        body: Center(
          child: _createList(context),
        ),
      ),
    );
  }

  Widget _createList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          return Container(
            child: _ordersHistory(position),
          );
        },
      ),
    );
  }

Future<ListTile> obtenerPagina1()async{
    final duration  = new Duration(seconds: 2);
     new Timer(duration, (){
    },
    );
    return Future.delayed(duration);
  }

Widget _ordersHistory(int position){
  if(items[position].userName == 'absa garcia'){
      return new Container(
        height: 60.0,
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                  color: Theme.CompanyColors.black[400],
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 3.0))
            ],
            gradient: new LinearGradient(
                colors: [
                  Theme.CompanyColors.black[50],
                  Theme.CompanyColors.black[500]
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp)),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(left:15, right: 10)),
            new Expanded(
              flex: 6,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(height: 15.0,),
                      new Text(
                        '${items[position].name}',
                        style: new TextStyle(
                            fontSize: 24.0,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                ],
              ),
            ),
            new Padding(padding: new EdgeInsets.only(left:10, right: 10)),
            new Expanded(
              flex: 1,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(height: 25.0,),
                  new Text(
                    '\$${items[position].total}',
                    style: new TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            new Padding(padding: new EdgeInsets.only(left:10, right: 10)),
            new Expanded(
              flex: 3,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(height: 8.0,),
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    buttonColor: Theme.CompanyColors.black[200],
                    child: RaisedButton(
                      onPressed: () {
                        showDialog(context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                  contentPadding: EdgeInsets.only(top: 10.0),
                                  backgroundColor: Theme.CompanyColors.black[200],
                                  content: Container(
                                    width: 350,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(height: 15.0,),
                                        Text(
                                          "${items[position].name} ",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Theme.CompanyColors.black[500]),
                                          textAlign: TextAlign.center,
                                        ),
                                        Divider(height: 25,),
                                        Text('Cantidad: ${items[position].cuantity}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Theme.CompanyColors.black[500]),
                                        textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text('Lugar de Entrega: ${items[position].place}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Theme.CompanyColors.black[500]),
                                        textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text('A cobrar: \$${items[position].total}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Theme.CompanyColors.black[500]),
                                        textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20.0,),
                                      ],
                                    )
                                  ),
                                );
                              }
                            );
                          }
                        );
                      },
                      child: Text("VER"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );             
  }
}
  
void _onProductAdded(Event event) {
  setState(() {
    items.add(new Order.fromSnapShot(event.snapshot));
  });
}

void _onProductUpdate(Event event) {
  var oldProductValue = items.singleWhere((product) =>  product.id == event.snapshot.key);
  setState(() {
    items[items.indexOf(oldProductValue)] = new Order.fromSnapShot(event.snapshot);
  });
}

}