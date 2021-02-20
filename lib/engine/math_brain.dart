import 'dart:math';
import 'package:flutter/material.dart';
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
    while (randomNumber1 == randomNumber2) {
      randomNumber2 = random.nextInt(maxNumber);
    }
    notifyListeners();
  }

  void getLessOrMoreResult() {
    if (randomNumber1 > randomNumber2) {
      lessOrMoreAnswer = Answer.left;
    } else if (randomNumber1 < randomNumber2) {
      lessOrMoreAnswer = Answer.right;
    } else {
      lessOrMoreAnswer = Answer.equal;
    }
    notifyListeners();
  }
}
