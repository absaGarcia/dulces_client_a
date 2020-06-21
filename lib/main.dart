import 'models/candy_data.dart';
import 'sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart' as Theme;

void main() => runApp(DulcesClient());

class DulcesClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CandyData(),
      child: MaterialApp( 
        color: Theme.CompanyColors.black[500],
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          scaffoldBackgroundColor: Theme.CompanyColors.black[100],
          primaryColor: Theme.CompanyColors.black[500],
        ),

        home: SideBarLayout(),

      ),
    );
  }
}
