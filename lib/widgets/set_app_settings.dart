import 'package:flutter/material.dart';

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
  //TODO: add a retunr bottun at the bottom
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
    return FlatButton(
      onPressed: () {
        showDialog<void>(context: context, builder: (context) => dialog);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        height: 120,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(children: [
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
      ),
    );
  }
}
