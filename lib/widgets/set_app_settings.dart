import 'package:flutter/material.dart';

import 'AppIconButtons.dart';

class SetAppSettings extends StatelessWidget {
  SetAppSettings(
      {@required this.selctedIcon,
      @required this.buttonText,
      @required this.popUpWidget,
      this.popText,
      this.dialog});

  final SimpleDialog dialog;
  final IconData selctedIcon;
  final String buttonText;
  final String popText;
  final Widget popUpWidget;

  @override
  Widget build(BuildContext context) {
    final SimpleDialog dialog = SimpleDialog(
      backgroundColor: Colors.blue,
      title: Text(
        popText,
        style: TextStyle(fontSize: 30.0),
      ),
      elevation: 30.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 90.0),
      children: [
        popUpWidget,
      ],
    );
    return AppIconButtons(
      presWidget: () {
        showDialog<void>(context: context, builder: (context) => dialog);
      },
      buttonIcon: Column(children: [
        Icon(
          selctedIcon,
          size: 40.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          buttonText,
        ),
      ]),
      iconColors: Colors.blue[300],
    );
  }
}
