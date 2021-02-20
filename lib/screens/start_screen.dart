import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/screens/math_qustions.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:one_to_math/widgets/sizebox.dart';

class MathStartScreen extends StatefulWidget {
  MathStartScreen({this.title});
  static const String id = 'start_screen';

  final String title;
  @override
  _MathStartScreen createState() => _MathStartScreen();
}

class _MathStartScreen extends State<MathStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                tooltip: "Settings",
                iconSize: 40.0,
                icon: Icon(FontAwesomeIcons.wrench),
                onPressed: () {
                  //page not active yet
                  // Navigator.pushNamed(context, SettingsScreen.id);
                },
              ),
              SizedBox(
                width: 30.0,
              ),
            ]),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              child: ButtonIcons(FontAwesomeIcons.minus, FontAwesomeIcons.plus),
              color: Colors.blue[300],
              onPressed: () {
                Navigator.pushNamed(context, MathQustions.id);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              child: ButtonIcons(
                  FontAwesomeIcons.greaterThan, FontAwesomeIcons.lessThan),
              color: Colors.blue[300],
              onPressed: () {
                Navigator.pushNamed(context, WhoIsBiggerScreen.id);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}
