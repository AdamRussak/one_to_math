import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_to_math/engine/math_brain.dart';
import 'package:one_to_math/engine/saved_info.dart';
import 'package:one_to_math/widgets/AppIconButtons.dart';
import 'package:one_to_math/widgets/app_title_widget.dart';
import 'package:one_to_math/widgets/result_counter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:after_layout/after_layout.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MathQustions extends StatefulWidget {
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
      sucessInt = savedInfo.prefs.getInt('prefMathCount') != null
          ? savedInfo.prefs.getInt('prefMathCount')
          : 0;
      scoreKeeper = sucessInt;
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

  var inputFieldNode;
  @override
  void initState() {
    super.initState();
    tapIntoSavedInfo();
    inputFieldNode = FocusNode();
  }

  @override
  void dispose() {
    inputFieldNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Height (without SafeArea)
    double height1 = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: AppTitleWidget(),
          ),
          body: Center(
            child: Consumer<MathBrain>(builder: (context, mathModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: size.width * 0.05),
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
                    height: height1 * 0.025,
                  ),
                  ResultCounterWidget(
                      sucessInt: sucessInt == null ? 0 : sucessInt),
                  SizedBox(
                    height: height1 * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIconButtons(
                        presWidget: () {
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
                              intAnswer == null ||
                                      answerTextController.text == ""
                                  ? 0
                                  : intAnswer,
                              userInput);
                          answerTextController.clear();
                        },
                        buttonIcon: Icon(
                          FontAwesomeIcons.cashRegister,
                          size: 45.0,
                        ),
                        iconColors: Colors.green,
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      AppIconButtons(
                        presWidget: () {
                          print('new qustion');
                          mathModel.getMathQustion();
                        },
                        buttonIcon: KNewQustionIcon,
                        iconColors: Colors.blue,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height1 * 0.05,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      mathModel.randomNumber1 != null
                          ? mathModel.randomNumber1.toString()
                          : "",
                      style: KmathStyle,
                    ),
                    KSizeBoxMath10,
                    Icon(Provider.of<MathBrain>(context, listen: false)
                            .randomMathBoolean
                        ? FontAwesomeIcons.plus
                        : FontAwesomeIcons.minus),
                    KSizeBoxMath10,
                    Text(
                      mathModel.randomNumber2 != null
                          ? mathModel.randomNumber2.toString()
                          : "",
                      style: KmathStyle,
                    ),
                    KSizeBoxMath10,
                    Icon(FontAwesomeIcons.equals),
                    KSizeBoxMath10,
                    SizedBox(
                      width: size.width * 0.2,
                      child: TextField(
                        autofocus: true,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: answerTextController,
                        maxLength:
                            Provider.of<MathBrain>(context, listen: false)
                                .maxNumber
                                .toString()
                                .length,
                        enabled: Provider.of<MathBrain>(context, listen: false)
                                    .questionResult ==
                                null
                            ? false
                            : true,
                        style: TextStyle(
                            color: Colors.black, fontSize: 35, height: 2),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(4),
                            filled: true,
                            fillColor:
                                Provider.of<MathBrain>(context, listen: false)
                                            .questionResult ==
                                        null
                                    ? Colors.grey[850]
                                    : Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mathModel.questionResult == null
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
                    height: height1 * 0.1,
                  ),
                ],
              );
            }),
          )),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    print(MediaQuery.of(context).size);
    // Calling the same function "after layout" to resolve the issue.
    Provider.of<MathBrain>(context, listen: false)
        .loadSavedInt(KMaxInt, MathTask.math);
  }
}
