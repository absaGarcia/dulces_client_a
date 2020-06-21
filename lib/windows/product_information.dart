import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import '../objects/product.dart';
import '../objects/order.dart';

class ProductInformation extends StatefulWidget {
  final Product product;
  ProductInformation(this.product);
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

final orderReference = FirebaseDatabase.instance.reference().child('order');
final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductInformationState extends State<ProductInformation> {

  List<Product> items;
  int cuantity =0;
  int total=0;
  List<Order> orders;
  String stockFirebase;

  TextEditingController _nameController;
  TextEditingController _cuantityController;
  TextEditingController _priceController;
  TextEditingController _descriptionController;
  TextEditingController _stockController;
  TextEditingController _userName;
  TextEditingController _totalController;

  List _place =['Mesas de la entrada','Jardineras', 'Edificio L','Mesas del F' ];
  String _optionPlace ='Mesas de la entrada';
  

  // StreamSubscription<Event> _onAddOrderStreamSubscription;
  @override
  void initState() {
    
    super.initState();
    orders = new List();
    items = new List();
    // _onAddOrderStreamSubscription = orderReference.onChildAdded.listen( _onOrderAdd);
    _totalController =  new TextEditingController(text: total.toString());
    _nameController = new TextEditingController(text: widget.product.name);
    _priceController = new TextEditingController(text: widget.product.price);
    _stockController = new TextEditingController(text:widget.product.stock);
    _descriptionController = new TextEditingController(text:widget.product.description);
  }

  @override
  Widget build(BuildContext context) {

      int price =  int.parse(widget.product.price);
      int stock= int.parse(widget.product.stock);
      int newStock; 
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
                    Text("${widget.product.name}",
                    style: TextStyle(fontSize: 18.0),),
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
                                total = price*cuantity;
                              }  
                            });
                          }, child: Icon(FontAwesomeIcons.plus),
                          shape: CircleBorder(),
                          color: Colors.amberAccent,
                          ),
                      ],
                    ),
                    SizedBox(height: 15.0,),    
                     _crearDropdown(),
                    SizedBox(height: 15.0,),
                    Text('Total: \$${(total).toString()}',
                    
                    ),
                    SizedBox(height: 15.0,),
                    RawMaterialButton(onPressed:(){
                      _userName = new TextEditingController(text:'absa garcia');
                      _totalController = new TextEditingController(text: total.toString());
                      _cuantityController = new TextEditingController(text: cuantity.toString());
                      _stockController = TextEditingController(text:(stock-cuantity).toString());
                      setState((){
                        if(cuantity>0){
                        _updateStock();
                        _onOrderAdd();
                      }
                      });
                      },
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
          'userName': _userName.text,
          'total' : _totalController.text,
          'place': _optionPlace,
        }).then((_) => Navigator.pop(context),);
     });
  }

  void _updateStock(){
    setState(() {
    if(widget.product.id != null){
      productReference.child(widget.product.id).set({
       'name' : _nameController.text,
       'description' : _descriptionController.text,
       'price' : _priceController.text,
       'stock' : _stockController.text, 
      });
    }
    });
  }
  
    Widget _crearDropdown() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        SizedBox(width:20),
        Icon(Icons.gps_not_fixed),
        SizedBox(width:20),
        Text('Ubicacion'),
        SizedBox(width:20),  
        Expanded(
          child: DropdownButton(
          value: _optionPlace,
          items: getOcionDropDown(), 
          onChanged: (opt){
            setState(() {
              _optionPlace =opt;
            });
              }
            ),
          ),
        ],
      );
    }
  
    List<DropdownMenuItem<String>> getOcionDropDown(){
      List<DropdownMenuItem<String>> lista = new List();
      _place.forEach((poder) { 
        lista.add(DropdownMenuItem(
          child: Text(poder),
          value: poder,
          ),
        );
      });
      return lista;
    }
  }
  