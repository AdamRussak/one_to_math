import 'package:flutter/material.dart';

class WhoIsBiggerScreen extends StatefulWidget {
  WhoIsBiggerScreen({this.title});
  static const String id = 'who_is_bigger_screen';
  final String title;
  @override
  _WhoIsBiggerScreenState createState() => _WhoIsBiggerScreenState();
}

class _WhoIsBiggerScreenState extends State<WhoIsBiggerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('who is bigger page will be here'),
      ),
    );
  }
}
