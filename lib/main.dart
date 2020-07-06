import 'sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'theme.dart' as Theme;

void main() => runApp(DulcesClient());

class DulcesClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Theme.CompanyColors.black[500],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Theme.CompanyColors.black[100],
        primaryColor: Theme.CompanyColors.black[500],
      ),
      home: SideBarLayout(),
    );
  }
}
