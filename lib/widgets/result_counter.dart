import 'package:flutter/material.dart';
import 'package:one_to_math/const_enums.dart';

class ResultCounterWidget extends StatelessWidget {
  const ResultCounterWidget({
    @required this.sucessInt,
  });

  final int sucessInt;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.green[100])),
          child: Text(
            sucessInt.toString(),
            style: KmathStyle,
          )),
      Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            ':רצף תרגילים',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          )),
    ]);
  }
}
