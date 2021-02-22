import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/saved_info.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/result_counter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:after_layout/after_layout.dart';
import 'package:one_to_math/const_enums.dart';
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
  int scoreKeeper = 0;
  int sucessInt;
  //alert Dialog for: approve see ansewr/ wrong answer/ right answer/ see answer
  //init the SharedPref
  SavedInfo savedInfo = SavedInfo();
  void tapIntoSavedInfo() async {
    await savedInfo.initSharedPrefs();
    setState(() {
      sucessInt = savedInfo.prefs.getInt('prefMathCount');
    });
  }

  void checkAnsewr(int userAnswer, bool checkInput) {
    if (userAnswer ==
            Provider.of<MathBrain>(context, listen: false).questionResult &&
        checkInput) {
      setState(() {
        scoreKeeper++;
        savedInfo.saveDataToPrefs(scoreKeeper, 'prefMathCount');
        sucessInt = savedInfo.prefs.getInt('prefMathCount');
      });

      //Alert Dialog's
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
            child: KNewQustionIcon,
            onPressed: () {
              Navigator.pop(context);
              Provider.of<MathBrain>(context, listen: false).getMathQustion();
              setState(() {
                userInput = false;
                userAnswer = null;
              });
            },
            width: 150,
            color: Colors.black45,
          )
        ],
      ).show();
    } else if (userAnswer !=
            Provider.of<MathBrain>(context, listen: false).questionResult &&
        checkInput) {
      Fluttertoast.showToast(
          msg: "תשובה לא נכונה, נסי/ה שנית",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (!checkInput) {
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
          child: KNewQustionIcon,
          onPressed: () {
            Navigator.pop(context);
            Provider.of<MathBrain>(context, listen: false).getMathQustion();
            setState(() {
              scoreKeeper = 0;
              savedInfo.saveDataToPrefs(scoreKeeper, 'prefMathCount');
              sucessInt = savedInfo.prefs.getInt('prefMathCount');
            });
          },
          width: 150,
          color: Colors.black45,
        )
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    tapIntoSavedInfo();
  }

  Widget build(BuildContext context) {
    return Consumer<MathBrain>(
      builder: (context, mathBrain, child) {
        return Scaffold(
          appBar: AppBar(
            title: AppTitleWidget(),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ResultCounterWidget(
                    sucessInt: sucessInt == null ? 0 : sucessInt),
                SizedBox(
                  height: 30.0,
                ),
                FlatButton(
                  onPressed: mathBrain.getMathQustion,
                  child: KNewQustionIcon,
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
                  Icon(mathBrain.randomMathBoolean
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
                    if (answerTextController.text == null ||
                        answerTextController.text == "") {
                      intAnswer = 1;
                      userInput = false;
                    } else {
                      intAnswer = int.parse(answerTextController.text);
                      userInput = true;
                    }
                    checkAnsewr(
                        intAnswer == null || answerTextController.text == ""
                            ? 0
                            : intAnswer,
                        userInput);
                    answerTextController.clear();
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
    Provider.of<MathBrain>(context, listen: false).getMathQustion();
  }
}
