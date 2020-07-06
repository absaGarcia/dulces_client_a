import 'package:dulces_client_a/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dulces_client_a/navigation_bloc/navigation.dart';
import '../components/rounded_button.dart';
import '../bloc/provider.dart';

final bloc = LoginBloc();
class LoginScreen extends StatefulWidget with NavigationStates {
   
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
   final _auth = FirebaseAuth.instance;
  final txtEmailController = TextEditingController();
  final txtPassController = TextEditingController();
  String email;
  String password;
 
  void loginAction(BuildContext context) async {
    if (password.length <= 6) {
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
          });
    }
    if (password.length > 6) {
      Auth auth = Auth();
      String uid = "delfina";//await auth.signIn(email, password);
      if (uid != "error") {
        setState(() {
          BlocProvider.of<NavigationBloc>(context)
              .add(NavigationEvents.LisViewEvent);
        });
      } else {
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
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo_dulces.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              StreamBuilder(
                stream: bloc.emailStream ,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return Container(
                    child:   TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  bloc.changeEmail;
                  email = value;
                },
                decoration: InputDecoration(
                  counterText: snapshot.data,
                  hintText: 'Ingresa tu Correo',
                  labelText: 'Ingresa tu Correo',
                  errorText: snapshot.error,
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
                  );
                },
              ),
           
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Ingresa tu Contrasena',
                  labelText: 'Ingresa tu Contrasena',
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
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                labelText: 'Ingresar',
                color: Colors.amber,
                onPressed: ()async{
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                    BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.LisViewEvent);

                    }
                
                  } catch (e) {
                    print(e);
                  }
                  
                  // loginAction(context);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder(
                stream:bloc.formValidStream ,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  return Container(
                    child: FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.RegisterEvent);
                  },
                  child: Text(
                    'Registrate Aqui',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
