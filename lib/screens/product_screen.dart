import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../components/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ProductScreen extends StatefulWidget {
  static String id = 'product_screen';
  final Product product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductScreenState extends State<ProductScreen> {

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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Dulces'),
        backgroundColor: Colors.deepOrangeAccent,        
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
             children: <Widget>[
               TextField(
                 controller: _nameController,
                 style: TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                 decoration: InputDecoration(icon:Icon(FontAwesomeIcons.candyCane),
                 labelText: 'Nombre'),
               ),
               Padding(padding: EdgeInsets.only(top:8.0),),
               Divider(),
               TextField(
                 controller: _descriptionController,
                 style: TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                 decoration: InputDecoration(icon:Icon(Icons.list),
                 labelText: 'Descripcion'),
               ),
               Padding(padding: EdgeInsets.only(top:8.0),),
               Divider(),
               TextField(
                 controller: _priceController,
                 style: TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                 decoration: InputDecoration(icon:Icon(Icons.monetization_on),
                 labelText: 'Precio'),
               ),
               Padding(padding: EdgeInsets.only(top:8.0),),
               Divider(),
                TextField(
                 controller: _stockController,
                 style: TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                 decoration: InputDecoration(icon:Icon(Icons.shop),
                 labelText: 'Cantidad'),
               ),
               Padding(padding: EdgeInsets.only(top:8.0),),
               Divider(),
               FlatButton(onPressed:(){
                 if (widget.product.id != null) {
                   productReference.child(widget.product.id).set({
                     'name' : _nameController.text,
                     'description' : _descriptionController.text,
                     'price' : _priceController.text,
                     'stock' : _stockController.text, 
                   }).then((_){
                     Navigator.pop(context);
                   });
                 }else{
                   productReference.push().set({
                       'name' : _nameController.text,
                     'description' : _descriptionController.text,
                     'price' : _priceController.text,
                     'stock' : _stockController.text, 
                   }).then((_){
                     Navigator.pop(context);
                   });
                 }
                },
                child: (widget.product.id != null)? Text('Actualizar') : Text('Agregar'),  
               ),
             ], 
            ),
          ),          
        ),
      ),
    );
  }
}