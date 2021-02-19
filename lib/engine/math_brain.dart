import 'dart:math';
import 'package:flutter/material.dart';

class MathBrain extends ChangeNotifier {
  //random Init
  Random random = Random();
  int maxNumber = 10;
  int randomNumber1;
  int randomNumber2;
  int questionResult;
  bool randomBoolean = true;

//new Math Question
  void getQustion() {
    getRandomBool();
    getRandomInt();
    getResult();
    notifyListeners();
  }

  //random number
  void getRandomInt() {
    if (randomBoolean) {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = random.nextInt(maxNumber - randomNumber1);
    } else {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = randomNumber1 == 0 ? 0 : random.nextInt(randomNumber1);
    }

    notifyListeners();
  }

  // random Bool
  void getRandomBool() {
    randomBoolean = random.nextBool();
    notifyListeners();
  }

  void getResult() {
    if (randomBoolean) {
      questionResult = randomNumber1 + randomNumber2;
    } else {
      questionResult = randomNumber1 - randomNumber2;
    }
    notifyListeners();
  }
}
