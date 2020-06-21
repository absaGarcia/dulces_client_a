
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import '../objects/product.dart';
import '../objects/order.dart';
import '../windows/product_information.dart';
import '../products/product_screen.dart';
import '../theme.dart' as Theme;


class ListViewProducts extends StatefulWidget with NavigationStates{
  @override
  _ListViewProductsState createState() => _ListViewProductsState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ListViewProductsState extends State<ListViewProducts> {
  List<Product> items;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangeSubscription;

  List<Order> itemOrder;
  @override
  void initState() {
    super.initState();
    items = new List();
    itemOrder = new List();
    _onProductAddedSubscription =
        productReference.onChildAdded.listen(_onProductAdded);
    _onProductChangeSubscription =
        productReference.onChildChanged.listen(_onProductUpdate);
   
  }

  @override
  void dispose() {
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangeSubscription.cancel();

  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Container(
        child:  ListView.builder(
          padding: EdgeInsets.only(top: 12.0),
          itemCount: items.length,
          itemBuilder: (context, position) {
            return Container(
              child: buildListTile(position),    
            );
          },
        ),
      ),  
    );
  }

  Widget buildListTile(int position) {
    if (items[position].stock != null) {
    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        boxShadow: [ BoxShadow( color: Theme.CompanyColors.black[400], blurRadius: 3.0, spreadRadius: 1.0, offset: Offset(0.0, 3.0)) ],
          gradient: new LinearGradient(colors: [Theme.CompanyColors.black[50], Theme.CompanyColors.black[500]],
              begin: Alignment.centerLeft, end: Alignment.centerRight, tileMode: TileMode.clamp)
              ),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left: 15.0, right: 10.0, top: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('images/kitkat.png', width: 90.0, height: 90.0, fit: BoxFit.fill),
              ),
            //CircleAvatar(radius: 35.0, backgroundImage: AssetImage('images/person.png'),)
          ),
          new Expanded(child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SizedBox(height: 30.0,),
              new Text('${items[position].name}', style: new TextStyle(fontSize: 18.0, color: Colors.white70, fontWeight: FontWeight.bold),),
              new SizedBox(height: 8.0,),
              new Text('${items[position].description}', style: new TextStyle(fontSize: 14.0, color: Colors.white70),),
              new SizedBox(height: 10.0,),
            ],),),
          new Padding(padding: new EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _createOrder( context, items[position]);
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: Theme.CompanyColors.black[500],
                  ),
                  shape: CircleBorder(),
                  color: Theme.CompanyColors.black[200],
                ),
              ],),),
        ],
        ),
      );
    }
  }

void _createOrder(BuildContext context, Product product)async{
  await Navigator.push(context, 
   MaterialPageRoute(builder:(context)=> ProductInformation(product)),
   );
}

void _onProductAdded(Event event) {
  setState(() {
    items.add(new Product.fromSnapShot(event.snapshot));
  });
}

void _onProductUpdate(Event event) {
  var oldProductValue = items.singleWhere((product) =>  product.id == event.snapshot.key);
  setState(() {
    items[items.indexOf(oldProductValue)] = new Product.fromSnapShot(event.snapshot);
  });
}

void _navigateToProductInformation(BuildContext context, Product product)async{
   await Navigator.push(context, 
   MaterialPageRoute(builder:(context)=> ProductScreen(product)),
   );
}

void _navigateToProduct(BuildContext context, Product product)async{
   await Navigator.push(context, 
   MaterialPageRoute(builder:(context)=> ProductInformation(product)),
   );
}

}

