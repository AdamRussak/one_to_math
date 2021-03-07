import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/widgets/AppIconButtons.dart';
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
    var size = MediaQuery.of(context).size;
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
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.0,
                ),
                AppIconButtons(
                  presWidget: () {
                    Navigator.pop(context);
                  },
                  buttonIcon: KPopIcon,
                  iconColors: Colors.red[300],
                ),
              ],
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            SizedBox(
              height: 100.0,
            ),
            Consumer<SettingsBrain>(builder: (context, settingBrain, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(children: [
                      Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.mars,
                            color: Colors.blue[300],
                            size: 60.0,
                          ),
                          Radio(
                            groupValue: settingBrain.kidsGender,
                            value: KidsGender.boy,
                            onChanged: (value) {
                              settingBrain.setGenderLurning(value);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.venus,
                            color: Colors.blue[300],
                            size: 60.0,
                          ),
                          Radio(
                            groupValue: settingBrain.kidsGender,
                            value: KidsGender.gairl,
                            onChanged: (value) {
                              settingBrain.setGenderLurning(value);
                            },
                          )
                        ],
                      ),
                    ]),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<MathBrain>(builder: (context, mathBrain, child) {
                  mathBrain.loadSavedInt(KMaxInt, MathTask.settings);
                  int currentInt = mathBrain.maxNumber;
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    height: 120,
                    width: 205,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.angleDoubleUp,
                                color: Colors.blue[300],
                              ),
                              iconSize: 35.0,
                              onPressed: () {
                                currentInt =
                                    currentInt >= 1000 ? 1000 : currentInt + 10;
                                mathBrain.updateMaxInt(currentInt, KMaxInt);
                              },
                            ),
                            Text(
                              mathBrain.maxNumber.toString(),
                              style: TextStyle(
                                  fontSize: 35.0, color: Colors.blue[300]),
                            ),
                            IconButton(
                              iconSize: 35.0,
                              icon: Icon(
                                FontAwesomeIcons.angleDoubleDown,
                                color: Colors.blue[300],
                              ),
                              onPressed: () {
                                currentInt =
                                    currentInt <= 10 ? 10 : currentInt - 10;
                                mathBrain.updateMaxInt(currentInt, KMaxInt);
                              },
                            ),
                          ],
                        ),
                        Text(
                          "תוצאה מקסימלית",
                          style: TextStyle(color: Colors.blue[300]),
                        )
                      ],
                    ),
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
                      AppIconButtons(
                        presWidget: () {
                          settingBrain.updateName(
                              nameTextController.text, 'prefUserName');
                          nameTextController.clear();
                          Navigator.pop(context);
                        },
                        buttonIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('שמור'),
                          ],
                        ),
                        iconColors: Colors.white,
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
