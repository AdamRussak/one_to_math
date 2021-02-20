import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/math_brain.dart';
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

var userAnswer;
int scoreKeeper = 0;
int sucessInt;
final answerTextController = TextEditingController();

class _WhoIsBiggerScreenState extends State<WhoIsBiggerScreen> {
  void checkAnsewr(userAnswer) {
    if (userAnswer ==
        Provider.of<MathBrain>(context, listen: false).lessOrMoreAnswer) {
      setState(() {
        scoreKeeper++;
        // savedInfo.saveDataToPrefs(scoreKeeper);
        // sucessInt = savedInfo.prefs.getInt('preflessOrMoreCount');
      });

      //Alert Dialog's
      Alert(
        context: context,
        type: AlertType.success,
        title: "!תשובה נכונה",
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
            Provider.of<MathBrain>(context, listen: false)
                .getLessOrMoreQustion();
            setState(() {
              scoreKeeper = 0;
              // savedInfo.saveDataToPrefs(scoreKeeper);
              // sucessInt = savedInfo.prefs.getInt('prefMathCount');
            });
          },
          width: 150,
          color: Colors.black45,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MathBrain>(builder: (context, mathBrain, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
              FlatButton(
                onPressed: mathBrain.getLessOrMoreQustion,
                child: KNewQustionIcon,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    setState(() {
                      userAnswer = Answer.left;
                    });
                    checkAnsewr(userAnswer);
                    print(Provider.of<MathBrain>(context, listen: false)
                        .lessOrMoreAnswer);
                  },
                  child: Text(
                    mathBrain.randomNumber1 != null
                        ? mathBrain.randomNumber1.toString()
                        : "A",
                    style: KmathStyle,
                  ),
                ),
                KSizeBoxMath10,
                Icon(
                  FontAwesomeIcons.question,
                  size: 50.0,
                ),
                KSizeBoxMath10,
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    setState(() {
                      userAnswer = Answer.right;
                    });
                    checkAnsewr(userAnswer);
                  },
                  child: Text(
                    mathBrain.randomNumber2 != null
                        ? mathBrain.randomNumber2.toString()
                        : "B",
                    style: KmathStyle,
                  ),
                )
              ]),
            ],
          ),
        ),
      );
    });
  }
}
