
import 'package:dulces_client_a/components/order.dart';
import 'package:dulces_client_a/screens/car_shop.dart';
import 'package:dulces_client_a/screens/product_information.dart';
import 'package:dulces_client_a/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import '../components/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
          title: Text('Product Information'),
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
                            'images/logo_dulces.png',
                            height: 130.0,
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
            leading: Icon(Icons.receipt),
            title: Text('Pedidos'),
            onTap: () {
              //Navigator.pushNamed(context, OrdersPage.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Productos'),
            onTap: () {
              Navigator.pushNamed(context, ListViewProducts.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text('Agregar Productos'),
            onTap: () {
              //Navigator.pushNamed(context, CarShop.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.remove_shopping_cart),
            title: Text('Modificar Productos'),
             onTap: () {
            
            },
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Historial de Pedidos'),
            onTap: () {
              // change app state...
           
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.calendarWeek),
            title: Text('Configurar Recompensas'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuracion de la Cuenta'),
          ),
        ],
      ),
    ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 7.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
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
                        ),
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
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => _createNewProduct(context),
        ),
      ),
    );
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

void _createNewProduct(BuildContext context)async{
   await Navigator.push(context, 
   MaterialPageRoute(builder:(context)=> ProductScreen(Product(null,'','','',''))),
   );
}

}