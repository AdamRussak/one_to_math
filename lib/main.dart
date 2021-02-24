import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:provider/provider.dart';
import 'screens/math_qustions.dart';
import 'screens/start_screen.dart';

//https://medium.com/codespace69/flutter-how-does-multiprovider-work-with-providers-of-the-same-type-bd632bd2cbad

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MathBrain>(create: (context) => MathBrain()),
        ChangeNotifierProvider<SettingsBrain>(
            create: (context) => SettingsBrain()),
      ],
      child: MaterialApp(
          theme: ThemeData.dark(),
          initialRoute: MathStartScreen.id,
          routes: {
            // LoadingScreen.id: (context) => LoadingScreen(),
            MathStartScreen.id: (context) => MathStartScreen(),
            MathQustions.id: (context) => MathQustions(),
            SettingsScreen.id: (context) => SettingsScreen(),
            WhoIsBiggerScreen.id: (context) => WhoIsBiggerScreen(),
          }),
    );
  }
}
