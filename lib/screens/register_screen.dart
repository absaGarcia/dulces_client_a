import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart' as Theme;

class RegisterScreen extends StatefulWidget with NavigationStates{
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600.0,
        margin: const EdgeInsets.symmetric(vertical: 130, horizontal: 15),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Theme.CompanyColors.black[400],
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 5.0))
          ],
          gradient: new LinearGradient(
            colors: [
              Theme.CompanyColors.black[300],
              Theme.CompanyColors.black[200],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.clamp
          )
        ),

        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 105),
                  child: Image.asset('images/logo_dulces.png', height: 140, width: 140,),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  hintStyle: TextStyle(
                    color: Colors.black45,
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
            ),  
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Correo',
                  hintStyle: TextStyle(
                    color: Colors.black45,
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
            ), 
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  hintStyle: TextStyle(
                    color: Colors.black45,
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
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Confirmar Contraseña',
                  hintStyle: TextStyle(
                    color: Colors.black45,
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: RoundedButton(
                labelText: 'Ingresar',
                color: Colors.amber,
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.LisViewEvent);

                  // loginAction(context);
                },
              ),  
            ),
            
          ],
        ),
      );
  }
}
