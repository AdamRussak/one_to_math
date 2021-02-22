import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
const KAppBarText = 'עומר לומדת חשבון';

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
