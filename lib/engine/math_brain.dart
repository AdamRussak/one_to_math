import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/saved_info.dart';

class MathBrain extends ChangeNotifier {
  //random Init
  SavedInfo savedInfo = SavedInfo();
  Random random = Random();
  int maxNumber = 10;
  int randomNumber1;
  int lastRandomNumber1;
  int randomNumber2;
  int questionResult;
  bool randomMathBoolean = true;
  bool randomMultyBoolean = true;
  var lessOrMoreAnswer;
  var lessOrMoreAnswerIcon;
  var multyResult;
//set qustion's Max
  void setQustionMax(int newMax) {
    maxNumber = newMax;
  }

  // load sved maxInt
  void loadSavedInt(String stringKey, dynamic taskEnum) async {
    await savedInfo.initSharedPrefs();
    maxNumber = savedInfo.prefs.getInt(stringKey) != null
        ? savedInfo.prefs.getInt(stringKey)
        : 10;
    if (taskEnum == MathTask.math) {
      getMathQustion();
    } else if (taskEnum == MathTask.lesOrMore) {
      getLessOrMoreQustion();
    } else if (taskEnum == MathTask.multy) {
      getMultiplyRandomInt();
    }
    notifyListeners();
  }

  //update int to pref shareed
  void updateMaxInt(int newInt, String prefKey) async {
    maxNumber = newInt;
    await savedInfo.initSharedPrefs();
    savedInfo.saveDataToPrefs(maxNumber, prefKey);
    notifyListeners();
  }

//new Math Question
  void getMathQustion() {
    getMathRandomBool();
    getMathRandomInt();
    getMathResult();
    notifyListeners();
  }

//new Multy or devide Question
  void getMultyOrDevideQustion() {
    getMultyRandomBool();
    if (randomMultyBoolean == true) {
      getMultiplyRandomInt();
    } else {
      geDevideRandomInt();
    }
    notifyListeners();
  }

  //random number for + - qustions
  void getMathRandomInt() {
    lastRandomNumber1 = lastRandomNumber1 == null ? 0 : lastRandomNumber1;
    if (randomMathBoolean) {
      do {
        randomNumber1 = random.nextInt(maxNumber);
        randomNumber2 = random.nextInt(maxNumber - randomNumber1);
      } while (lastRandomNumber1 == randomNumber1);
    } else {
      do {
        randomNumber1 = random.nextInt(maxNumber);
        randomNumber2 = randomNumber1 == 0 ? 0 : random.nextInt(randomNumber1);
      } while (lastRandomNumber1 == randomNumber1);
    }
    updateLastResult(randomNumber1);
    notifyListeners();
  }

  //update Last result var
  void updateLastResult(int lastReult) {
    lastRandomNumber1 = lastReult;
    notifyListeners();
  }

  //random number for Multiply qustions
  void getMultiplyRandomInt() {
    do {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = random.nextInt(maxNumber);
      multyResult = randomNumber1 * randomNumber2;
    } while (multyResult >= maxNumber ||
        multyResult == 0 ||
        randomNumber1 == lastRandomNumber1);
    updateLastResult(randomNumber1);
    notifyListeners();
  }

  //random number for devide qustions
  void geDevideRandomInt() {
    do {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = random.nextInt(maxNumber);
      while (randomNumber1 <= 0 || randomNumber1 < randomNumber2) {
        randomNumber1 = random.nextInt(maxNumber);
        randomNumber2 = random.nextInt(randomNumber1);
      }
      multyResult = randomNumber1 / randomNumber2;
    } while (multyResult % 1 != 0 || randomNumber1 == lastRandomNumber1);
    multyResult = (randomNumber1 / randomNumber2).round();
    updateLastResult(randomNumber1);
    notifyListeners();
  }

  // random Bool for math qustions
  void getMathRandomBool() {
    randomMathBoolean = random.nextBool();
    notifyListeners();
  }

  // random Bool for Multy and devide qustions
  void getMultyRandomBool() {
    randomMultyBoolean = random.nextBool();
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
    do {
      randomNumber1 = random.nextInt(maxNumber);
      randomNumber2 = random.nextInt(maxNumber);
    } while (randomNumber1 == lastRandomNumber1);
    updateLastResult(randomNumber1);
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
    //

    notifyListeners();
  }

  //setting qustion limit
  void setQustionsInt(int newInt) {
    maxNumber = newInt;
  }
}
