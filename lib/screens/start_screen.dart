import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tempName = "עומר";
    var tempGender;

    return Scaffold(
      appBar: AppBar(
        title: AppTitleWidget(),
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
                    // Navigator.pushNamed(context, SettingsScreen.id);
                  }),
              SizedBox(
                width: 30.0,
              ),
            ]),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SetAppSettings(
                  popUpWidget: CustomNumberPicker(
                    initialValue: 10,
                    maxValue: 1000000,
                    minValue: 10,
                    step: 10,
                    onValue: (value) {
                      print(value.toString());
                    },
                  ),
                  popText: "בחר מספר מקסימלי",
                  selctedIcon: FontAwesomeIcons.smileBeam,
                  buttonText: "מספר מקסימלי",
                ),
                SetAppSettings(
                  popUpWidget: Column(children: [
                    TextField(
                      controller: nameTextController,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.right,
                      onChanged: (newText) {
                        print(newText);
                      },
                    ),
                    FlatButton(
                      child: Text('שמור'),
                      onPressed: () {
                        print('did 0');
                        setState(() {
                          tempName = nameTextController.text;
                        });
                        Provider.of<SettingsBrain>(context, listen: false)
                            .updateName(tempName);
                        nameTextController.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ]),
                  popText: ":שם",
                  selctedIcon: FontAwesomeIcons.grinHearts,
                  buttonText: "שם הילד/ה",
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
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
          ],
        ),
      ),
    );
  }
}
