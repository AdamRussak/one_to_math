import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:after_layout/after_layout.dart';
import 'package:one_to_math/const.dart';

class MathSettings extends StatefulWidget {
  MathSettings({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MathSettings>
    with AfterLayoutMixin<MathSettings> {
  void checkAnsewr(int result) {
    Alert(
      context: context,
      type: AlertType.none,
      title: "The Answer is:",
      desc: result.toString(),
      style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
      buttons: [
        DialogButton(
          child: Text(
            "New Qustion",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 150,
          color: Colors.black45,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MathBrain>(
      builder: (context, mathBrain, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    mathBrain.randomNumber1 != null
                        ? mathBrain.randomNumber1.toString()
                        : "",
                    style: KmathStyle,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: mathBrain.randomBoolean
                        ? FaIcon(FontAwesomeIcons.plus)
                        : FaIcon(FontAwesomeIcons.minus),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    mathBrain.randomNumber2 != null
                        ? mathBrain.randomNumber2.toString()
                        : "",
                    style: KmathStyle,
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.equals),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      enabled: mathBrain.questionResult == null ? false : true,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(4),
                          filled: true,
                          fillColor: mathBrain.questionResult == null
                              ? Colors.grey[850]
                              : Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: mathBrain.questionResult == null
                                  ? Colors.grey[850]
                                  : Colors.blue,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          )),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      onChanged: (newText) {},
                    ),
                  ),
                ]),
                SizedBox(
                  height: 30.0,
                ),
                FlatButton(
                  textColor: Colors.white,
                  child: Text(
                    'Check Ansewr',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressed: () {
                    //The user picked true.
                    checkAnsewr(mathBrain.questionResult);
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: mathBrain.getQustion,
            tooltip: 'newMath Qustion',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    Provider.of<MathBrain>(context, listen: false).getQustion();
  }
}
