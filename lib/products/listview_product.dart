import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import '../objects/product.dart';
import '../objects/order.dart';
import '../products/product_screen.dart';
import '../theme.dart' as Theme;

class ListViewProducts extends StatefulWidget with NavigationStates {
  @override
  static String id = 'listview_products';
  _ListViewProductsState createState() => _ListViewProductsState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ListViewProductsState extends State<ListViewProducts> {
  List<Product> items;
  int cuantity = 0;
  int total = 0;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangeSubscription;
  List _place = [
    'Mesas de la entrada',
    'Jardineras',
    'Edificio L',
    'Mesas del F'
  ];
  String _optionPlace = 'Mesas de la entrada';

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
        child: ListView.builder(
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
        margin: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                  color: Theme.CompanyColors.black[400],
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 3.0))
            ],
            gradient: new LinearGradient(
                colors: [
                  Theme.CompanyColors.black[50],
                  Theme.CompanyColors.black[500]
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp)),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(left: 15.0, right: 10.0, top: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('images/kitkat.png',
                    width: 90.0, height: 90.0, fit: BoxFit.fill),
              ),
            ),
            new Expanded(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    height: 30.0,
                  ),
                  new Text(
                    '${items[position].name}',
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                  new SizedBox(
                    height: 8.0,
                  ),
                  new Text(
                    '${items[position].description}',
                    style: new TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _createOrder(context, position);
                      });
                    },
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Theme.CompanyColors.black[500],
                    ),
                    shape: CircleBorder(),
                    color: Theme.CompanyColors.black[200],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  int updateCuantity(int cuantity) {
    return cuantity;
  }

  void _createOrder(BuildContext context, int position) async => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        cuantity = 0;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              backgroundColor: Theme.CompanyColors.black[200],
              content: Container(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Producto ${items[position].name} ",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Theme.CompanyColors.black[500]),
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      height: 45,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Precio: \$${items[position].price} ",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.CompanyColors.black[500]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Total: \$${(total).toString()} ',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.CompanyColors.black[500]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              if (cuantity > 0) {
                                cuantity--;
                                total =
                                    int.parse(items[position].price) * cuantity;
                                print(cuantity);
                              }
                            });
                          },
                          child: Icon(FontAwesomeIcons.minus,
                              color: Theme.CompanyColors.black[200]),
                          shape: CircleBorder(),
                          color: Theme.CompanyColors.black[400],
                        ),
                        Text('${cuantity = updateCuantity(cuantity)}'),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              if (cuantity >= 0) {
                                cuantity++;
                                print(cuantity);
                                total =
                                    int.parse(items[position].price) * cuantity;
                              }
                            });
                          },
                          child: Icon(FontAwesomeIcons.plus,
                              color: Theme.CompanyColors.black[200]),
                          shape: CircleBorder(),
                          color: Theme.CompanyColors.black[400],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    _crearDropdown(),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () {
//                        _userName =
//                            new TextEditingController(text: 'absa garcia');
//                        _totalController =
//                            new TextEditingController(text: total.toString());
//                        _cuantityController = new TextEditingController(
//                            text: cuantity.toString());
//                        _stockController = TextEditingController(
//                            text: (stock - cuantity).toString());
//                        setState(() {
//                          if (cuantity > 0) {
//                            _updateStock();
//                            _onOrderAdd();
//                          }
//                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Theme.CompanyColors.black[400],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Agregar al carrito",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });

  Widget _crearDropdown() {
    return Container(
        alignment: Alignment.center,
        color: Theme.CompanyColors.black[200],
        child: Row(
          children: <Widget>[
            SizedBox(width: 50),
            Icon(
              Icons.gps_not_fixed,
              color: Theme.CompanyColors.black[500],
            ),
            SizedBox(width: 20),
            Expanded(
              child: DropdownButton(
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 42,
                underline: SizedBox(),
                value: _optionPlace,
                items: getOcionDropDown(),
                onChanged: (opt) {
                  setState(() {
                    _optionPlace = opt;
                  });
                },
                style: TextStyle(color: Theme.CompanyColors.black[200]),
              ),
            ),
          ],
        ));
  }

  List<DropdownMenuItem<String>> getOcionDropDown() {
    List<DropdownMenuItem<String>> lista = new List();
    _place.forEach((poder) {
      lista.add(
        DropdownMenuItem(
          child: Text(
            poder,
            style:
                TextStyle(color: Theme.CompanyColors.black[500], fontSize: 18),
          ),
          value: poder,
        ),
      );
    });
    return lista;
  }

  void _onProductAdded(Event event) {
    setState(() {
      items.add(new Product.fromSnapShot(event.snapshot));
    });
  }

  void _onProductUpdate(Event event) {
    var oldProductValue =
        items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
          new Product.fromSnapShot(event.snapshot);
    });
  }

  void _navigateToProductInformation(
      BuildContext context, Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product)),
    );
  }

  void _navigateToProduct(
      BuildContext context, Product product, int cant) async {
    //await Navigator.push(
    //context,
    //MaterialPageRoute(builder: (context) => ProductInformation(product, cant)),
    //);
  }
}
