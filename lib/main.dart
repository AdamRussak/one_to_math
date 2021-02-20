import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:provider/provider.dart';
import 'const_enums.dart';
import 'screens/math_qustions.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MathBrain(),
      child: MaterialApp(
          title: KAppBarText,
          theme: ThemeData.dark(),
          initialRoute: MathStartScreen.id,
          routes: {
            MathStartScreen.id: (context) =>
                MathStartScreen(title: KAppBarText),
            MathQustions.id: (context) => MathQustions(title: KAppBarText),
            SettingsScreen.id: (context) => SettingsScreen(title: KAppBarText),
            WhoIsBiggerScreen.id: (context) =>
                WhoIsBiggerScreen(title: KAppBarText),
          }),
    );
  }
}
