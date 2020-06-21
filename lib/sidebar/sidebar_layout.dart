import 'package:flutter_bloc/flutter_bloc.dart';
import '../navigation_bloc/navigation.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class SideBarLayout extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      body: BlocProvider <NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationStates){
                return navigationStates as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}