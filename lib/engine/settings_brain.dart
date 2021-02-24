import 'package:flutter/material.dart';
import 'package:one_to_math/const_enums.dart';
import 'package:one_to_math/engine/saved_info.dart';

class SettingsBrain extends ChangeNotifier {
  SavedInfo savedInfo = SavedInfo();
  int maxNumber = 10;
  String userName = "עומר";
  String genderLurning = "לומדת";
  String _enumString;
  var kidsGender = KidsGender.gairl;

  void setStartString(String prefKey) async {
    await savedInfo.initSharedPrefs();
    _enumString = savedInfo.prefs.getString(prefKey) != null
        ? savedInfo.prefs.getString(prefKey)
        : "gairl";
    if (_enumString == 'gairl') {
      kidsGender = KidsGender.gairl;
    } else if (_enumString == 'boy') {
      kidsGender = KidsGender.boy;
    }
    setGenderLurning(kidsGender);
  }

  void setGenderLurning(newkidsGender) {
    if (KidsGender.gairl == newkidsGender) {
      genderLurning = "לומדת";
      _enumString = 'gairl';
      kidsGender = KidsGender.gairl;
      saveStringToSharedPrefs(_enumString, KGender);
    } else {
      genderLurning = "לומד";
      kidsGender = KidsGender.boy;
      _enumString = 'boy';
      saveStringToSharedPrefs(_enumString, KGender);
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
