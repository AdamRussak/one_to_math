import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';

class MathBrain extends ChangeNotifier {
  //random Init
  Random random = Random();
  int maxNumber = 10;
  int randomNumber1;
  int randomNumber2;
  int questionResult;
  bool randomMathBoolean = true;
  var lessOrMoreAnswer;
  var lessOrMoreAnswerIcon;
//set qustion's Max
  void setQustionMax(int newMax) {
    maxNumber = newMax;
  }

//new Math Question
  void getMathQustion() {
    getMathRandomBool();
    getMathRandomInt();
    getMathResult();
    notifyListeners();
  }

  //random number for + - qustions
  void getMathRandomInt() {
    if (randomMathBoolean) {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = random.nextInt(maxNumber - randomNumber1);
    } else {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = randomNumber1 == 0 ? 0 : random.nextInt(randomNumber1);
    }
    notifyListeners();
  }

  // random Bool
  void getMathRandomBool() {
    randomMathBoolean = random.nextBool();
    notifyListeners();
  }

  void getMathResult() {
    if (randomMathBoolean) {
      questionResult = randomNumber1 + randomNumber2;
    } else {
      questionResult = randomNumber1 - randomNumber2;
    }
    notifyListeners();
  }

  //new  less or equal  Question
  void getLessOrMoreQustion() {
    getRandomLessOrMoreInt();
    getLessOrMoreResult();
    notifyListeners();
  }

  //random number for less or equal qustions
  void getRandomLessOrMoreInt() {
    randomNumber1 = random.nextInt(maxNumber);
    randomNumber2 = random.nextInt(maxNumber);
    notifyListeners();
  }

  void getLessOrMoreResult() {
    if (randomNumber1 > randomNumber2) {
      lessOrMoreAnswer = Answer.left;
      lessOrMoreAnswerIcon = Icon(FontAwesomeIcons.greaterThan);
    } else if (randomNumber1 < randomNumber2) {
      lessOrMoreAnswer = Answer.right;
      lessOrMoreAnswerIcon = Icon(FontAwesomeIcons.lessThan);
    } else {
      lessOrMoreAnswer = Answer.equal;
      lessOrMoreAnswerIcon = Icon(FontAwesomeIcons.equals);
    }
    notifyListeners();
  }

  //setting qustion limit
  int setQustionsInt(int newInt) {
    maxNumber = newInt;
    return maxNumber;
  }
}
