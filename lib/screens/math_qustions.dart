import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:after_layout/after_layout.dart';
import 'package:one_to_math/const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MathQustions extends StatefulWidget {
  MathQustions({this.title});

  final String title;
  static const String id = 'math_qustions';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MathQustions>
    with AfterLayoutMixin<MathQustions> {
  final answerTextController = TextEditingController();
  String userAnswer;
  bool userInput = false;

  //alert Dialog for: approve see ansewr/ wrong answer/ right answer/ see answer
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
            child: KNewQustion,
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
        title: "?!?בטוח",
        desc: "שווה לנסות",
        style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
        buttons: [
          DialogButton(
            child: Icon(FontAwesomeIcons.eye),
            onPressed: () {
              Navigator.pop(context);
              showAnswer();
            },
            width: 150,
            color: Colors.black45,
          ),
          DialogButton(
            child: Icon(FontAwesomeIcons.undo),
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

  void showAnswer() {
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
          child: KNewQustion,
          onPressed: () {
            Navigator.pop(context);
            Provider.of<MathBrain>(context, listen: false).getQustion();
          },
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
                SizedBox(
                  height: 30.0,
                ),
                FlatButton(
                  onPressed: mathBrain.getQustion,
                  child: KNewQustion,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    mathBrain.randomNumber1 != null
                        ? mathBrain.randomNumber1.toString()
                        : "",
                    style: KmathStyle,
                  ),
                  KSizeBoxMath10,
                  Icon(mathBrain.randomBoolean
                      ? FontAwesomeIcons.plus
                      : FontAwesomeIcons.minus),
                  KSizeBoxMath10,
                  Text(
                    mathBrain.randomNumber2 != null
                        ? mathBrain.randomNumber2.toString()
                        : "",
                    style: KmathStyle,
                  ),
                  KSizeBoxMath10,
                  Icon(FontAwesomeIcons.equals),
                  KSizeBoxMath10,
                  SizedBox(
                    width: 65,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: answerTextController,
                      maxLength: mathBrain.maxNumber.toString().length,
                      maxLengthEnforced: true,
                      enabled: mathBrain.questionResult == null ? false : true,
                      style: TextStyle(
                          color: Colors.black, fontSize: 35, height: 2),
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
                      },
                    ),
                  ),
                ]),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                  textColor: Colors.white,
                  child: Icon(
                    FontAwesomeIcons.cashRegister,
                    size: 50.0,
                  ),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    var intAnswer;
                    //The user picked true.
                    if (userAnswer == null || userAnswer == "") {
                      intAnswer = 1;
                    } else {
                      intAnswer = int.parse(userAnswer);
                      userInput = true;
                    }
                    checkAnsewr(
                        intAnswer == null || userAnswer == "" ? 0 : intAnswer,
                        userInput);
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
