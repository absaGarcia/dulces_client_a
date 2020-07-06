import 'package:dulces_client_a/screens/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/login_screen.dart';
import '../products/listview_product.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  LoginEvent,
  PedidosEvent,
  RegisterEvent,
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
        case NavigationEvents.RegisterEvent:
        yield RegisterScreen();
        break;

        default:
      }
    }
}