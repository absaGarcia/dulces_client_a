import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../navigation_bloc/navigation.dart';
import '../sidebar/sidebar.dart';
import '../objects/product.dart';

class CarShop extends StatefulWidget with NavigationStates{
  final Product product;
  CarShop(this.product);
  @override
  _CarShopState createState() => _CarShopState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _CarShopState extends State<CarShop> {

  
  List<Product> items;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  TextEditingController _stockController;

@override
  void initState() {
    
    super.initState();
    _nameController = new TextEditingController(text: widget.product.name);
    _descriptionController = new TextEditingController(text: widget.product.description);
    _priceController = new TextEditingController(text: widget.product.price);
    _stockController = new TextEditingController(text:widget.product.stock);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
        centerTitle: true,
      ),
      drawer: SideBar(),
      body: Container(),
    );
  }
}