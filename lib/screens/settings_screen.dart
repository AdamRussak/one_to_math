import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/set_app_settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({this.title});
  static const String id = 'settings_screen';
  final String title;
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameTextController = TextEditingController();
  IconData dropdownValue = FontAwesomeIcons.venus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AppTitleWidget(),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            //TODO: add Consumer and set variaables for the sttings
            DropdownButton<IconData>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(),
              onChanged: (IconData newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <IconData>[
                FontAwesomeIcons.venus,
                FontAwesomeIcons.mars,
              ].map<DropdownMenuItem<IconData>>((IconData value) {
                return DropdownMenuItem<IconData>(
                  value: value,
                  child: Icon(
                    value,
                    size: 60.0,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: set the Pref Sherd to save the INT for next usage
                Consumer<MathBrain>(builder: (context, mathBrain, child) {
                  var newInt;
                  return SetAppSettings(
                    popUpWidget: Column(
                      children: [
                        CustomNumberPicker(
                          initialValue: 10,
                          maxValue: 1000000,
                          minValue: 10,
                          step: 10,
                          onValue: (value) {
                            newInt = value;
                            print(value.toString());
                          },
                        ),
                        FlatButton(
                          child: Text('שמור'),
                          onPressed: () {
                            mathBrain.setQustionMax(newInt);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    popText: ":בחר/י",
                    selctedIcon: FontAwesomeIcons.smileBeam,
                    buttonText: "מספר מקסימלי",
                  );
                }),
                Consumer<SettingsBrain>(
                    builder: (context, settingBrain, child) {
                  return SetAppSettings(
                    popUpWidget: Column(children: [
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[\u0590-\u05fe]')),
                        ],
                        controller: nameTextController,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.right,
                        onChanged: (newText) {
                          print(newText);
                        },
                      ),
                      FlatButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('שמור'),
                          ],
                        ),
                        onPressed: () {
                          settingBrain.updateName(
                              nameTextController.text, 'prefUserName');
                          nameTextController.clear();
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                    popText: ":שם",
                    selctedIcon: FontAwesomeIcons.grinHearts,
                    buttonText: "שם הילד/ה",
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
