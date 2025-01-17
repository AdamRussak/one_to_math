import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/settings_brain.dart';
import 'package:one_to_math/screens/help_screen.dart';
import 'package:one_to_math/screens/multiply_qustions.dart';
import 'package:one_to_math/screens/settings_screen.dart';
import 'package:one_to_math/screens/who_is_bigger_screen.dart';
import 'package:provider/provider.dart';
import 'screens/math_qustions.dart';
import 'screens/start_screen.dart';

//https://medium.com/codespace69/flutter-how-does-multiprovider-work-with-providers-of-the-same-type-bd632bd2cbad

void main() => runApp(MyApp());

//TODO: start new option for total cunting qustions
//TODO: set a page with few missions ( 10,20,50 qustions task // time test: 5, 10, 15 minuts test)
//TODO: create top score page
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MathBrain>(create: (context) => MathBrain()),
        ChangeNotifierProvider<SettingsBrain>(
            create: (context) => SettingsBrain()),
      ],
      child: MaterialApp(
          title: 'עומר לומדת חשבון',
          theme: ThemeData.dark(),
          initialRoute: MathStartScreen.id,
          routes: {
            MultiplyQustions.id: (context) => MultiplyQustions(),
            MathStartScreen.id: (context) => MathStartScreen(),
            MathQustions.id: (context) => MathQustions(),
            SettingsScreen.id: (context) => SettingsScreen(),
            WhoIsBiggerScreen.id: (context) => WhoIsBiggerScreen(),
            HelpScreen.id: (context) => HelpScreen(),
          }),
    );
  }
}
