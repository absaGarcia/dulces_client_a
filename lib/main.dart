import 'package:dulces_client_a/screens/candy_page.dart';
import 'package:dulces_client_a/screens/login_screen.dart';
import 'package:dulces_client_a/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(DulcesClient());

class DulcesClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        CandyPage.id: (context) => CandyPage(),
      },
    );
  }
}
