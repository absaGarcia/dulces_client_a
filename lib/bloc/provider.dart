import 'package:flutter/material.dart';
import 'login_bloc.dart';
export 'login_bloc.dart';

class Provider extends InheritedWidget{
  
  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child,);
    }

    return _instancia;
  }


  final loginBloc = LoginBloc();

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  // Provider._internal();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
}
}