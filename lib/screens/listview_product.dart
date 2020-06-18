
import 'package:dulces_client_a/components/order.dart';
import 'package:dulces_client_a/screens/car_shop.dart';
import 'package:dulces_client_a/screens/product_information.dart';
import 'package:dulces_client_a/screens/product_screen.dart';
import 'package:dulces_client_a/screens/select_place.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import '../components/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'orderhistory_screen.dart';


class ListViewProducts extends StatefulWidget {
  static String id = 'listview_products'; 
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Dulces',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dulces'),
          centerTitle: true,
        ),
        drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(
                            'images/person.png',
                            height: 100.0,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Usuario',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Puntos: 0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Telefono',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Productos'),
            onTap: () {
              Navigator.pushNamed(context, ListViewProducts.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Carrito'),
            onTap: () {
              Navigator.pushNamed(context, CarShop.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text('Elige Ubicacion Actual'),
            onTap: () {
              Navigator.pushNamed(context, SelectPlace.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Historial de Pedidos'),
            onTap: () {
              // change app state...
              Navigator.pushNamed(context, OrderHistory.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Recompensas'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuracion'),
          ),
        ],
      ),
    ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 7.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: buildListTile(position),
                        ),
                        IconButton(   
                          icon: Icon(
                            Icons.add,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              _createOrder( context, items[position]),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        
      ),
    );
  }

  ListTile buildListTile(int position) {
    if (items[position].stock != null) {
    return ListTile(
            title: Text(
            '${items[position].name}',
            style: TextStyle(
            color: Colors.white,
            fontSize: 21.0,
              ),
            ),
            subtitle: Text(
            '${items[position].description}',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              ),
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