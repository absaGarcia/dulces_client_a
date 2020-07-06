import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import 'package:dulces_client_a/products/listview_product.dart';
import 'package:dulces_client_a/sidebar/sidebar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

FirebaseUser loggedUser;

class RegisterScreen extends StatefulWidget with NavigationStates{
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final personReference = FirebaseDatabase.instance.reference().child('person');


class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
   bool showSpinner = false;
  String email;
  String password;
  String password1;

  TextEditingController _personName;
  TextEditingController _emailController;
  TextEditingController _uidAuthController;
void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        print('=============');
        print(loggedUser.email);
        // print(loggedUser.uid.toString());
      
      }
    } catch (e) {
      print(e);
    }
    _uidAuthController = TextEditingController(text: loggedUser.uid.toString());
      _emailController = TextEditingController(text: email.toString());
    setState(() {
      personReference.push().set({
        'userProfile':_personName.text,
        'email'      :_emailController.text,
        'udiAuth'    :_uidAuthController.text,
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:'logo',
                  child: Image.asset('images/logo_dulces.png'),
                  ),
                ),
                 TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) => _personName=TextEditingController(text: value.toString()),
                decoration: InputDecoration(
                  labelText: 'Ingresa Tu Nombre',
                  hintText: 'Ingresa tu Nombre',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFECA703),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
               TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) => email=value,
                decoration: InputDecoration(
                  labelText: 'Ingresa Tu Correo',
                  hintText: 'Ingresa tu Correo',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFECA703),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                onChanged: (value){
                  password = value;
                },
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Ingresa Tu Contrasena',
                  hintText: 'Ingresa tu Contrasena',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFECA703),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) => password1=value,
                decoration: InputDecoration(
                  alignLabelWithHint:true,
                  labelText:  'Reingresa tu Contrasena',
                  hintText: 'Reingresa tu Contrasena',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFECA703),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                labelText: 'Registrarse',
                color: Colors.amber,
                onPressed: () async {
                  setState(() {
                   
                  });
                  if(email == null || password == null)
                  {
                    print('puto');
                  }
                  if(email != null && password != null && password == password1){
                    try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    getCurrentUser();
                  
                    if (newUser != null) {
                       BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.PedidosEvent);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  
                    }
                  catch (e) {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return AlertDialog(
                      title: Text('Ocurrió un error, por favor vuelve a intentar'),
                      elevation: 24,
                      actions: <Widget>[
                      FlatButton(
                     child: Text('OK'),
                      onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
                  }
                  }
                  else{
                    showSpinner=false;
                    Navigator.pushNamed(context, RegisterScreen.id);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _personAdd(){
  
  }
}


