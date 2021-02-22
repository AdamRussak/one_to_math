import 'package:flutter/material.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';

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
        title: AppTitleWidget(),
      ),
      body: Center(
        child: Text('settings page will be here'),
      ),
    );
  }
}
