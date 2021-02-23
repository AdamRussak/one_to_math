import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/start_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with AfterLayoutMixin<LoadingScreen> {
  double latitude;
  double longitude;

  var getVars = "null";
  void getLocationData() {
    while (getVars == "null") {
      getVars = Provider.of<SettingsBrain>(context, listen: false).getuser();
      print(getVars);
    }
    print('afterLoop');
    print(getVars);
    navigator();
  }

  void navigator() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MathStartScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          duration: Duration(seconds: 5),
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    getVars = Provider.of<SettingsBrain>(context, listen: false).getuser();
    getLocationData();
  }
}
