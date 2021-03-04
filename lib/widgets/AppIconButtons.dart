import 'package:flutter/material.dart';

class AppIconButtons extends StatelessWidget {
  const AppIconButtons({this.presWidget, this.buttonIcon, this.iconColors});
  final Function presWidget;
  final Widget buttonIcon;
  final Color iconColors;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: buttonIcon,
        onPressed: presWidget,
        style: TextButton.styleFrom(
          primary: iconColors,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
