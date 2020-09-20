import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefService {
  Future<bool> isKeyPresent(String key);
  Future<void> storeItem(String key, dynamic value);
  Future<dynamic> getItem(String key);
}

class SharedPrefServiceImpl extends SharedPrefService {
  @override
  Future<bool> isKeyPresent(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  @override
  Future getItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> storeItem(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
}
