import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/login_screen.dart';
import '../products/listview_product.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  LoginEvent,
  PedidosEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  @override
  NavigationStates get initialState => LoginScreen();
  
    @override
    Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
      switch (event) {

        case NavigationEvents.LoginEvent:
          yield LoginScreen();
          break;
          
        case NavigationEvents.PedidosEvent:
          yield ListViewProducts();
          break;
          
        default:
      }
    }
}