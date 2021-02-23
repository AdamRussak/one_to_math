import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/math_qustions.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/set_app_settings.dart';
import 'package:one_to_math/widgets/sizebox.dart';
import 'package:provider/provider.dart';

class MathStartScreen extends StatefulWidget {
  static const String id = 'start_screen';

  @override
  _MathStartScreen createState() => _MathStartScreen();
}

class _MathStartScreen extends State<MathStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppTitleWidget(),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  tooltip: "Settings",
                  iconSize: 50.0,
                  icon: Icon(FontAwesomeIcons.wrench),
                  onPressed: () {
                    Navigator.pushNamed(context, SettingsScreen.id);
                  }),
              SizedBox(
                width: 30.0,
              ),
            ]),
            Text('הגדרות'),
            SizedBox(
              height: 60.0,
            ),
            //TODO: create male/ femal input
            //TODO: create on off for settings
            FlatButton(
              minWidth: 150.0,
              height: 100.0,
              child: ButtonIcons(FontAwesomeIcons.minus, FontAwesomeIcons.plus),
              color: Colors.blue[300],
              onPressed: () {
                Navigator.pushNamed(context, MathQustions.id);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 50.0,
            ),
            FlatButton(
              minWidth: 150.0,
              height: 100.0,
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
