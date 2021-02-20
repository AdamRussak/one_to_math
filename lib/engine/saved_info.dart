import 'package:shared_preferences/shared_preferences.dart';

class SavedInfo {
  SharedPreferences prefs;

//start the SharedPrefs Instance
  Future<Null> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveDataToPrefs(int qeueuCount) async {
    print('Saving data to form before Acting.......');
    prefs.setInt('prefMathCount', qeueuCount);
  }

  clearDataPrefs(String valueRemove) async {
    prefs.remove('prefMathCount');
  }
}
