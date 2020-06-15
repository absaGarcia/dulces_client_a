import 'dart:async';

import 'package:dulces_client_a/components/order.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import '../components/product.dart';

class ProductInformation extends StatefulWidget {
  final Product product;
  ProductInformation(this.product);
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

final orderReference = FirebaseDatabase.instance.reference().child('order');

class _ProductInformationState extends State<ProductInformation> {

  List<Product> items;
  int cuantity =0;
  int total=0;
  List<Order> orders;

  
  TextEditingController _nameController;
  TextEditingController _cuantityController;
  TextEditingController _priceController;
  TextEditingController _stockController;
  TextEditingController _userName;
  TextEditingController _totalController;




  // StreamSubscription<Event> _onAddOrderStreamSubscription;
  @override
  void initState() {
    
    super.initState();
    orders = new List();
    // _onAddOrderStreamSubscription = orderReference.onChildAdded.listen( _onOrderAdd);
    
    _nameController = new TextEditingController(text: widget.product.name);
    _priceController = new TextEditingController(text: widget.product.price);
    _stockController = new TextEditingController(text:widget.product.stock);
  }

  @override
  Widget build(BuildContext context) {

      int price =  int.parse(widget.product.price);
        return Scaffold(
          appBar: AppBar(
            title: Text('Agregar al Carrito'),
            centerTitle: true,
          ),
          body: Container(
            height: 500.0,
            padding:const EdgeInsets.all(20.0),
            child: Card(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.only(top:15.0),
                      ),
                    Text("Nombre: ${widget.product.name}",
                    style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Divider(),
                    Text("Descripcion: ${widget.product.description}",
                    style: TextStyle(fontSize: 18.0,),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Divider(),
                     Text("Precio: \$${widget.product.price}",
                    style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Divider(),
                    Text("Cantidad:", 
                    style: TextStyle(fontSize: 18.0),),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){
                            setState(() {
                              if(cuantity >0){
                                cuantity--;
                                total = price*cuantity;
                              }  
                            });
                          }, child: Icon(FontAwesomeIcons.minus),
                          shape: CircleBorder(),
                          color: Colors.amberAccent,
                          ),
                          Text('$cuantity'),
                          FlatButton(
                          onPressed: (){
                       
                            setState(() {
                            
                              if(cuantity >= 0){
                                cuantity++;
                              }  
                            });
                          }, child: Icon(FontAwesomeIcons.plus),
                          shape: CircleBorder(),
                          color: Colors.amberAccent,
                          ),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Text('Total: \$${().toString()}',
                    
                    ),
                    SizedBox(height: 15.0,),
                    RawMaterialButton(onPressed:(){
                      
                      _cuantityController = new TextEditingController(text: cuantity.toString());
                      _onOrderAdd();},
                  child: Text('Agregar'),
                  fillColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onOrderAdd(){
     setState(() {
        orderReference.push().set({
          'name' : _nameController.text,
          'cuantity' : _cuantityController.text,
          'userName': _userName,
          'total' : _totalController,
        }).then((_) => Navigator.pop(context),);
     });
  }



}