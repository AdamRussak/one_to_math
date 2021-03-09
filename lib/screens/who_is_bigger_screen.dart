import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/saved_info.dart';
import 'package:one_to_math/widgets/AppIconButtons.dart';
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
  int scoreKeeper;
  int sucessInt;
  final answerTextController = TextEditingController();
  SavedInfo savedInfo = SavedInfo();
  void tapIntoSavedInfo() async {
    await savedInfo.initSharedPrefs();
    setState(() {
      sucessInt = savedInfo.prefs.getInt('prefMoreOrLessCount') != null
          ? savedInfo.prefs.getInt('prefMoreOrLessCount')
          : 0;
      scoreKeeper = sucessInt;
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
        desc: "הספירה תתאפס",
        style: AlertStyle(descStyle: KmathStyle, titleStyle: KmathStyle),
        buttons: [
          DialogButton(
            child: Icon(FontAwesomeIcons.solidThumbsUp),
            onPressed: () {
              Navigator.pop(context);
              showAnswer();
            },
            width: 150,
            color: Colors.black45,
          ),
          DialogButton(
            child: Icon(FontAwesomeIcons.solidThumbsDown),
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
      title: "דלג/י שאלה",
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
    var size = MediaQuery.of(context).size;
    // Height (without SafeArea)
    double height1 = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Consumer<MathBrain>(builder: (context, mathBrain, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppTitleWidget(),
        ),
        body: Center(
          heightFactor: 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  AppIconButtons(
                    presWidget: () {
                      Navigator.pop(context);
                    },
                    buttonIcon: KPopIcon,
                    iconColors: Colors.red[300],
                  ),
                ],
              ),
              SizedBox(
                height: height1 * 0.05,
              ),
              ResultCounterWidget(
                sucessInt: sucessInt == null ? 0 : sucessInt,
              ),
              SizedBox(
                height: height1 * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIconButtons(
                    presWidget: () {
                      setState(() {
                        userAnswer = Answer.pass;
                      });
                      checkAnsewr(userAnswer);
                    },
                    buttonIcon: Icon(
                      FontAwesomeIcons.exchangeAlt,
                      size: 45.0,
                    ),
                    iconColors: Colors.redAccent,
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  AppIconButtons(
                    presWidget: mathBrain.getLessOrMoreQustion,
                    buttonIcon: KNewQustionIcon,
                    iconColors: Colors.blue[300],
                  ),
                ],
              ),
              SizedBox(
                height: height1 * 0.05,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  mathBrain.randomNumber1 != null
                      ? mathBrain.randomNumber1.toString()
                      : "A",
                  style: KMoreOrLessTextStyle,
                ),
                SizedBox(
                  width: size.width * 0.05,
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
                      height: height1 * 0.015,
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
                      height: height1 * 0.015,
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
                  width: size.width * 0.05,
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
    Provider.of<MathBrain>(context, listen: false)
        .loadSavedInt(KMaxInt, MathTask.lesOrMore);
  }
}
