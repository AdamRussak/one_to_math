import 'package:flutter/material.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:after_layout/after_layout.dart';
import 'package:one_to_math/const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MathSettings extends StatefulWidget {
  MathSettings({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MathSettings>
    with AfterLayoutMixin<MathSettings> {
  final answerTextController = TextEditingController();
  String userAnswer;
  bool userInput = false;
  void checkAnsewr(int userAnswer, bool userInput) {
    if (userAnswer ==
            Provider.of<MathBrain>(context, listen: false).questionResult &&
        userInput) {
      Alert(
        context: context,
        type: AlertType.success,
        title: ":התשובה",
        desc: Provider.of<MathBrain>(context, listen: false)
            .questionResult
            .toString(),
        style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
        buttons: [
          DialogButton(
            child: Text(
              "שאלה חדשה",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Provider.of<MathBrain>(context, listen: false).getQustion();
            },
            width: 150,
            color: Colors.black45,
          )
        ],
      ).show();
    } else if (userAnswer !=
            Provider.of<MathBrain>(context, listen: false).questionResult &&
        userInput) {
      Fluttertoast.showToast(
          msg: "תשובה לא נכונה, נסי/ה שנית",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (!userInput) {
      Alert(
        context: context,
        type: AlertType.none,
        title: ":התשובה",
        desc: Provider.of<MathBrain>(context, listen: false)
            .questionResult
            .toString(),
        style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
        buttons: [
          DialogButton(
            child: Text(
              "שאלה חדשה",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () {
              Navigator.pop(context);
              Provider.of<MathBrain>(context, listen: false).getQustion();
            },
            width: 150,
            color: Colors.black45,
          ),
          DialogButton(
            child: Text(
              "חזור",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 150,
            color: Colors.black45,
          )
        ],
      ).show();
    }
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
                SizedBox(
                  height: 30.0,
                ),
                FlatButton(
                  onPressed: mathBrain.getQustion,
                  child: Text(
                    "שאלה חדשה",
                    style: KmathButtonTextStyle,
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: 100.0,
                ),
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
                  Icon(mathBrain.randomBoolean
                      ? FontAwesomeIcons.plus
                      : FontAwesomeIcons.minus),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    mathBrain.randomNumber2 != null
                        ? mathBrain.randomNumber2.toString()
                        : "",
                    style: KmathStyle,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(FontAwesomeIcons.equals),
                  SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    width: 65,
                    child: TextField(
                      controller: answerTextController,
                      maxLength: mathBrain.maxNumber.toString().length,
                      maxLengthEnforced: true,
                      enabled: mathBrain.questionResult == null ? false : true,
                      style: TextStyle(
                          color: Colors.black, fontSize: 35, height: 1.2),
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
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      onChanged: (newText) {
                        userAnswer = newText;
                        userInput = true;
                      },
                    ),
                  ),
                ]),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                  textColor: Colors.white,
                  child: Text(
                    'בדוק תשובה',
                    style: KmathButtonTextStyle,
                  ),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    var intAnswer;
                    //The user picked true.
                    if (userAnswer == null) {
                      intAnswer = 1;
                    } else {
                      intAnswer = int.parse(userAnswer);
                    }
                    checkAnsewr(intAnswer == null ? 0 : intAnswer, userInput);
                    answerTextController.clear();
                    userInput = false;
                  },
                ),
              ],
            ),
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
