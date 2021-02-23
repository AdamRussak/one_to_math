import 'package:flutter/material.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/saved_info.dart';

class SettingsBrain extends ChangeNotifier {
  SavedInfo savedInfo = SavedInfo();
  int maxNumber = 10;
  String userName = "עומר";
  String genderLurning = "לומדת";
  dynamic kidsGender;

  void updateEnum(dynamic newState) {
    kidsGender = newState;
    kidsGender;
    setGenderLurning();
    notifyListeners();
  }

  void setGenderLurning() {
    if (kidsGender == KidsGender.gairl) {
      genderLurning = "לומדת";
    } else {
      genderLurning = "לומד";
    }
    notifyListeners();
  }

//update String to pref shareed
  void updateName(String newName, String prefKey) {
    userName = newName;
    saveStringToSharedPrefs(userName, prefKey);
    notifyListeners();
  }

  void saveStringToSharedPrefs(String tempName, String prefKey) async {
    await savedInfo.initSharedPrefs();
    savedInfo.saveStringToPrefs(tempName, prefKey);
    notifyListeners();
  }

  void loadSavedString(String stringKey) async {
    await savedInfo.initSharedPrefs();
    userName = savedInfo.prefs.getString(stringKey) != null
        ? savedInfo.prefs.getString(stringKey)
        : "עומר";
    print(userName);
    notifyListeners();
  }

  String getuser() {
    loadSavedString('prefUserName');
    return userName;
  }
}
