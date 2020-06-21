import 'package:flutter/material.dart';
import '../theme.dart' as Theme;

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Theme.CompanyColors.black[500],
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}