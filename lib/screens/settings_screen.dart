import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({this.title});
  static const String id = 'settings_screen';
  final String title;
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('settings page will be here'),
      ),
    );
  }
}
