<<<<<<< HEAD
import 'package:flutter/material.dart';

class MathStartScreen extends StatefulWidget {
  static const String id = 'start_screen';
=======
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/math_qustions.dart';
import 'package:one_to_math/screens/multiply_qustions.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/sizebox.dart';
import 'package:provider/provider.dart';

class MathStartScreen extends StatefulWidget {
  static const String id = 'start_screen';

>>>>>>> 4cf1eece119a2753a5071585d9234d5bb643f9be
  @override
  _MathStartScreen createState() => _MathStartScreen();
}

<<<<<<< HEAD
class _MathStartScreen extends State<MathStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
=======
class _MathStartScreen extends State<MathStartScreen>
    with AfterLayoutMixin<MathStartScreen> {
  var getVars = "null";
  void getLocationData() {
    while (getVars == "null") {
      getVars = Provider.of<SettingsBrain>(context, listen: false).getuser();
      print(getVars);
    }
    print('afterLoop');
    print(getVars);
  }

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
            SizedBox(
              height: 50.0,
            ),
            FlatButton(
              minWidth: 150.0,
              height: 100.0,
              child:
                  ButtonIcons(FontAwesomeIcons.divide, FontAwesomeIcons.times),
              color: Colors.blue[300],
              onPressed: () {
                Navigator.pushNamed(context, MultiplyQustions.id);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    Provider.of<SettingsBrain>(context, listen: false).setStartString(KGender);
    getVars = Provider.of<SettingsBrain>(context, listen: false).getuser();
    getLocationData();
>>>>>>> 4cf1eece119a2753a5071585d9234d5bb643f9be
  }
}
