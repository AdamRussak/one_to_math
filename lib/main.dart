import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/loading_screen.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:provider/provider.dart';
import 'const_enums.dart';
import 'screens/math_qustions.dart';
import 'screens/start_screen.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(providers: [
    Provider<MathBrain>(create: (_) => MathBrain()),
    Provider<SettingsBrain>(create: (_) => SettingsBrain()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsBrain(),
      child: MaterialApp(
          theme: ThemeData.dark(),
          initialRoute: LoadingScreen.id,
          routes: {
            LoadingScreen.id: (context) => LoadingScreen(),
            MathStartScreen.id: (context) => MathStartScreen(),
            MathQustions.id: (context) => MathQustions(),
            SettingsScreen.id: (context) => SettingsScreen(),
            WhoIsBiggerScreen.id: (context) => WhoIsBiggerScreen(),
          }),
    );
  }
}
