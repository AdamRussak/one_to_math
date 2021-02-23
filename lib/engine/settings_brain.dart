import 'package:flutter/material.dart';
import 'package:one_to_math/engine/saved_info.dart';

class SettingsBrain extends ChangeNotifier {
  // SavedInfo savedInfo = SavedInfo();
  int maxNumber = 10;
  String userName = "עומר";
  String genderLurning = "לומדת";
  void updateName(String newName) {
    userName = newName;
    saveToSharedPrefs(userName);
    notifyListeners();
  }

  void saveToSharedPrefs(String tempName) async {
    // await savedInfo.initSharedPrefs();
    // savedInfo.saveStringToPrefs(tempName, 'prefUserName');
    notifyListeners();
  }

  void loadSavedString(String stringKey) async {
    // await savedInfo.initSharedPrefs();
    // userName = savedInfo.prefs.getString(stringKey) != null
    //     ? savedInfo.prefs.getString(stringKey)
    //     : "עומר";
    // updateName(userName);
    updateName('עומר');
    print(userName);
    notifyListeners();
  }

  String getuser() {
    loadSavedString('prefUserName');
    return userName;
  }
}
