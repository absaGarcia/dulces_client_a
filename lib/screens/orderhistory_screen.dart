import 'dart:async';
import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../objects/order.dart';

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
      theme: ThemeData.dark(),
      title: 'Pedidos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pedidos'),
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
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Carrito'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text('Elige Ubicacion Actual'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Historial de Pedidos'),
            onTap: () {
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
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                elevation: 7,
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 7.0,
                    ),
                    Row(
                      children: <Widget>[
                     Expanded(child: _ordersHistory(position),),
                      ],
                    ),
                  ],
                ),
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

ListTile _ordersHistory(int position){
  if(items[position].userName == 'absa garcia'){
      return ListTile(
        title: Text(
          '${items[position].name}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 21.0, 
          ),
        ),
        subtitle: Text('Cantidad: ${items[position].cuantity}'),
        trailing: Text('${items[position].place}'),
        leading: Text('\$${items[position].total}'),
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