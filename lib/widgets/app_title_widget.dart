import 'package:flutter/material.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:provider/provider.dart';

class AppTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsBrain>(builder: (context, settingsModel, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(settingsModel.userName +
                " " +
                settingsModel.genderLurning +
                " " +
                KAppBarText),
            SizedBox(
              width: 10.0,
            ),
            Image.asset(
              'assets/barIcon.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    });
  }
}
