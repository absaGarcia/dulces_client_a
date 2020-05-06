import 'package:dulces_client_a/screens/car_shop.dart';
import 'package:dulces_client_a/screens/order_list.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                          Icon(
                            Icons.person,
                            size: 80.0,
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
            leading: Icon(Icons.shopping_cart),
            title: Text('Carrito'),
            onTap: () {
              Navigator.pushNamed(context, CarShop.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text('Elige Ubicacion Actual'),
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Historial de Pedidos'),
            onTap: () {
              // change app state...
              Navigator.pushNamed(context, OrderList.id);
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
    );
  }
}
