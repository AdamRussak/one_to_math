import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/saved_info.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/result_counter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WhoIsBiggerScreen extends StatefulWidget {
  WhoIsBiggerScreen({this.title});
  static const String id = 'who_is_bigger_screen';
  final String title;
  @override
  _WhoIsBiggerScreenState createState() => _WhoIsBiggerScreenState();
}

class _WhoIsBiggerScreenState extends State<WhoIsBiggerScreen>
    with AfterLayoutMixin<WhoIsBiggerScreen> {
  var userAnswer;
  int scoreKeeper = 0;
  int sucessInt;
  final answerTextController = TextEditingController();
  SavedInfo savedInfo = SavedInfo();
  void tapIntoSavedInfo() async {
    await savedInfo.initSharedPrefs();
    setState(() {
      sucessInt = savedInfo.prefs.getInt('prefMoreOrLessCount');
    });
  }

  void checkAnsewr(userAnswer) {
    if (userAnswer ==
        Provider.of<MathBrain>(context, listen: false).lessOrMoreAnswer) {
      setState(() {
        scoreKeeper++;
        savedInfo.saveDataToPrefs(scoreKeeper, 'prefMoreOrLessCount');
        sucessInt = savedInfo.prefs.getInt('prefMoreOrLessCount');
      });

      //Alert Dialog's
      Alert(
        context: context,
        type: AlertType.success,
        title: "!תשובה נכונה",
        image:
            Provider.of<MathBrain>(context, listen: false).lessOrMoreAnswerIcon,
        style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
        buttons: [
          DialogButton(
            child: KNewQustionIcon,
            onPressed: () {
              Navigator.pop(context);
              Provider.of<MathBrain>(context, listen: false)
                  .getLessOrMoreQustion();
              setState(() {
                userAnswer = null;
              });
            },
            width: 150,
            color: Colors.black45,
          )
        ],
      ).show();
    } else if (userAnswer == Answer.pass) {
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
    } else if (userAnswer !=
        Provider.of<MathBrain>(context, listen: false).lessOrMoreAnswer) {
      Fluttertoast.showToast(
          msg: "תשובה לא נכונה, נסי/ה שנית",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void showAnswer() {
    Alert(
      context: context,
      type: AlertType.none,
      image: Image(
        image: Provider.of<MathBrain>(context).lessOrMoreAnswerIcon,
      ),
      title: ":התשובה",
      style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
      buttons: [
        DialogButton(
          child: KNewQustionIcon,
          onPressed: () {
            Navigator.pop(context);
            Provider.of<MathBrain>(context, listen: false)
                .getLessOrMoreQustion();
            setState(() {
              scoreKeeper = 0;
              savedInfo.saveDataToPrefs(scoreKeeper, 'prefMoreOrLessCount');
              sucessInt = savedInfo.prefs.getInt('prefMoreOrLessCount');
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
    return Consumer<MathBrain>(builder: (context, mathBrain, child) {
      return Scaffold(
        appBar: AppBar(
          title: AppTitleWidget(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResultCounterWidget(
                sucessInt: sucessInt == null ? 0 : sucessInt,
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        userAnswer = Answer.pass;
                      });
                      checkAnsewr(userAnswer);
                    },
                    child: Icon(
                      FontAwesomeIcons.backspace,
                      size: 45.0,
                    ),
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  FlatButton(
                    onPressed: mathBrain.getLessOrMoreQustion,
                    child: KNewQustionIcon,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  mathBrain.randomNumber1 != null
                      ? mathBrain.randomNumber1.toString()
                      : "A",
                  style: KMoreOrLessTextStyle,
                ),
                SizedBox(
                  width: 30.0,
                ),
                Column(
                  children: [
                    IconButton(
                      color: Colors.deepPurple,
                      iconSize: 50.0,
                      icon: Icon(
                        FontAwesomeIcons.greaterThan,
                      ),
                      onPressed: () {
                        setState(() {
                          userAnswer = Answer.left;
                        });
                        checkAnsewr(userAnswer);
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    IconButton(
                      color: Colors.amber,
                      iconSize: 50.0,
                      icon: Icon(
                        FontAwesomeIcons.equals,
                      ),
                      onPressed: () {
                        setState(() {
                          userAnswer = Answer.equal;
                        });
                        checkAnsewr(userAnswer);
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    IconButton(
                      color: Colors.indigoAccent,
                      iconSize: 50.0,
                      icon: Icon(
                        FontAwesomeIcons.lessThan,
                      ),
                      onPressed: () {
                        setState(() {
                          userAnswer = Answer.right;
                        });
                        checkAnsewr(userAnswer);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  mathBrain.randomNumber2 != null
                      ? mathBrain.randomNumber2.toString()
                      : "B",
                  style: KMoreOrLessTextStyle,
                ),
              ]),
            ],
          ),
        ),
      );
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    Provider.of<MathBrain>(context, listen: false).getLessOrMoreQustion();
  }
}
