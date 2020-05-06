import 'package:flutter/material.dart';
import 'package:dulces_client_a/components/menu_lateral.dart';

class OrderList extends StatefulWidget {
  static String id = 'order_list';
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial De Pedidos'),
      ),
      drawer: MenuLateral(),
    );
  }
}
