import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const String id = 'help_screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TODO: finish writing all the help tasks
          Text('הגדרות'),
          Text('חיבור וחיסור'),
          Text('גדול או קטן'),
          Text('כפל וחילוק'),
        ],
      ),
    );
  }
}
