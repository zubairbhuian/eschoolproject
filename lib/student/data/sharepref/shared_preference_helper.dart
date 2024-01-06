import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper{

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.authToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(Preferences.authToken);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(Preferences.isLoggedIn) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setBool(Preferences.isLoggedIn, value);
  }

  Future<String?> get studentId async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.studentId);
  }

  Future<bool> saveStudentId(String studentId) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.studentId, studentId);
  }

  // Teacher ID get and save:---------------------------
  Future<String?> get teacherId async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.teacherId);
  }

  Future<bool> saveTeacherId(String teacherId) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.teacherId, teacherId);
  }

  // get and save login as student/teacher:------------------
  Future<String?> get logInAs async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.logInAs);
  }

  Future<bool> saveLogInAs(String logInAs) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.logInAs, logInAs);
  }

}