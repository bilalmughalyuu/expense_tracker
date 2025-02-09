import 'dart:convert';
import 'package:expense_tracker/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const USER_DATA = 'userData';
  static const IS_DARK_MODE = 'isDarkMode';

  Future<void> setUserData(UserModel data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_DATA, jsonEncode(data));
  }

  Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(USER_DATA)) {
      return userModelFromJson(prefs.getString(USER_DATA)!);
    }
    return null;
  }

  Future<void> setIsDarkMode(bool data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DARK_MODE, data);
  }

  Future<bool?> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(IS_DARK_MODE)) {
      return prefs.getBool(IS_DARK_MODE);
    }
    return false;
  }

  Future<bool> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userData")) {
      await prefs.remove("userData");
      return true;
    }
    return false;
  }
}
