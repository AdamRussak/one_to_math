import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/math_qustions.dart';
import 'package:one_to_math/screens/multiply_qustions.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:one_to_math/widgets/AppIconButtons.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/sizebox.dart';
import 'package:provider/provider.dart';

class MathStartScreen extends StatefulWidget {
  static const String id = 'start_screen';

  @override
  _MathStartScreen createState() => _MathStartScreen();
}

class _MathStartScreen extends State<MathStartScreen>
    with AfterLayoutMixin<MathStartScreen> {
  var getVars = "null";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              AppIconButtons(
                presWidget: () {
                  Navigator.pushNamed(context, MathQustions.id);
                },
                buttonIcon:
                    ButtonIcons(FontAwesomeIcons.minus, FontAwesomeIcons.plus),
                iconColors: Colors.blue[300],
              ),
              SizedBox(
                height: 50.0,
              ),
              AppIconButtons(
                presWidget: () {
                  Navigator.pushNamed(context, WhoIsBiggerScreen.id);
                },
                buttonIcon: ButtonIcons(
                    FontAwesomeIcons.lessThan, FontAwesomeIcons.greaterThan),
                iconColors: Colors.blue[300],
              ),
              SizedBox(
                height: 50.0,
              ),
              AppIconButtons(
                presWidget: () {
                  Navigator.pushNamed(context, MultiplyQustions.id);
                },
                buttonIcon: ButtonIcons(
                    FontAwesomeIcons.divide, FontAwesomeIcons.times),
                iconColors: Colors.blue[300],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    Provider.of<SettingsBrain>(context, listen: false).setStartString(KGender);
    Provider.of<SettingsBrain>(context, listen: false)
        .loadSavedString('prefUserName');
  }
}
