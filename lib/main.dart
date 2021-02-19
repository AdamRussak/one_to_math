import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:provider/provider.dart';
import 'screens/math_main.dart';

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
        title: 'עומר לומדת חשבון',
        theme: ThemeData.dark(),
        home: MathSettings(title: 'עומר לומדת חשבון'),
      ),
    );
  }
}
