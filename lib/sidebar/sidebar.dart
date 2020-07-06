import 'dart:async';
import 'package:dulces_client_a/products/listview_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../components/menu_item.dart';
import '../navigation_bloc/navigation.dart';
import '../theme.dart' as Theme;

FirebaseUser loggedUser;

class SideBar extends StatefulWidget{
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        print('=============');
        print(loggedUser.email);
        print(loggedUser.uid.toString());
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

 void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  Widget build(BuildContext context) {
    @override
    final screenWidth = MediaQuery.of(context).size.width;
    
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 30,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Theme.CompanyColors.black[400],
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Card(
                        color: Theme.CompanyColors.black[400],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: ListTile(                          
                          title: Text(
                            "Usuario",
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            "Ubicacion : F202",
                            style: TextStyle(
                              color: Theme.CompanyColors.black[500],
                              fontSize: 18,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                            ),
                            radius: 30,
                          ),
                        ),
                        ),
                      ),
                      Divider(
                        height: 20,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Inicio",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "Perfil",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.add_shopping_cart,
                        title: "Carrito",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.location_on,
                        title: "Cambiar Ubicacion",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.shopping_basket,
                        title: "Pedidos",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.OrderHistoryEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.star,
                        title: "Recompensas",
                        onTap: () {
                          onIconPressed();
                        },
                      ),


                      Divider(
                        height: 70,
                        thickness: 1.0,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Ajustes",
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Salir",
                        onTap: () {
                          onIconPressed();
                            _signOut();
                        }
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 30,
                      height: 110,
                      color: Theme.CompanyColors.black[400],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Theme.CompanyColors.black[300],
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

   _signOut()async{
    // _auth.signOut();
    // Future<FirebaseUser> user;
    // user=loggedUser;
    
    // user = FirebaseAuth.instance.currentUser();
    print('=============');
    print('exito');
    FirebaseAuth.instance.signOut();
    loggedUser =  await FirebaseAuth.instance.currentUser();
    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LoginEvent);
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}