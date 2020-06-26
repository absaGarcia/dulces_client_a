import 'package:dulces_client_a/components/rounded_button.dart';
import 'package:dulces_client_a/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dulces_client_a/screens/listview_product.dart';
import 'package:dulces_client_a/service/auth.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final txtNameController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtPassController = TextEditingController();

  void registerUser() async {
    String name = txtNameController.text;
    String email = txtEmailController.text;
    String password = txtPassController.text;
    
    if(password.length < 6){
      showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
                title: Text('La contraseña debe tener al menos 6 caracteres'),
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
            }
        );
    }else{
      Auth auth = Auth();
      String uid = await auth.signUp(email, password);
      if(uid != "error"){
        setState(() {
          Navigator.pushNamed(context, ListViewProducts.id);
        });
      }else{
        showDialog(
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
            }
        );
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Crea tu usuario!',
                  style: 
                    TextStyle(color: Colors.white, fontSize: 24)
                ),
                SizedBox(
                  height: 30.0,
                ),

                Text(
                  'Ingresa tu nombre y apellido'
                ),

                TextField(
                  controller: txtNameController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  maxLength: 40,
                  maxLengthEnforced: true,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nombre y apellido',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                  height: 30.0,
                ),

                Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: txtEmailController,
                      textAlign: TextAlign.center,
                      maxLength: 50,
                      maxLengthEnforced: true,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Correo electronico',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: txtPassController,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Ingresa tu Contrasena',
                hintStyle: TextStyle(
                  color: Colors.white70,
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Reingresa tu Contrasena',
                hintStyle: TextStyle(
                  color: Colors.white70,
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
              onPressed: () {
                registerUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
