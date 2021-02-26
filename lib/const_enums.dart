import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const KMaxInt = 'prefMaxInt';
const KGender = 'prefGender';
const KmathStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);
const KMoreOrLessTextStyle = TextStyle(
  fontSize: 70.0,
  fontWeight: FontWeight.bold,
);
const KmathButtonTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.w200,
);
const KAppBarText = 'חשבון';

const KNewQustionIcon = Icon(
  FontAwesomeIcons.magic,
  size: 45.0,
);
const KSizeBoxMath10 = SizedBox(
  width: 10.0,
);

enum Answer {
  equal,
  left,
  right,
  pass,
}
enum KidsGender {
  boy,
  gairl,
}
enum MathTask {
  math,
  lesOrMore,
  multy,
  settings,
}
