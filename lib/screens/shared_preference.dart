import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  setLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('login', true);
  }
}
