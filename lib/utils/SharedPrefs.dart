import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  // 私有构造函数
  SharedPrefsUtils._internal();

  Future<void> initSharedPref() async {
    if (!initial) {
      _prefs = await SharedPreferences.getInstance();
      initial = true;
    }
  }

  // 保存单例
  static final SharedPrefsUtils _singleton = SharedPrefsUtils._internal();

  // 工厂构造函数
  factory SharedPrefsUtils() => _singleton;

  late SharedPreferences _prefs;

  bool initial = false;

  Future<void> setInt(String key, int value) async {
    _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> setString(String key, String value) async {
    _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setObjectList<T extends Object>(
      String key, List<T> value) async {
    var list = value.map((e) => json.encode(e)).toList();
    _prefs.setStringList(key, list);
  }

  List<T>? getObjectList<T>(String key, Function(String origin) parseFn) {
    var list = _prefs.getStringList(key);
    var res = list?.map((e) => parseFn(e) as T).toList();
    return res;
  }
}

SharedPrefsUtils sharedPrefsUtils = SharedPrefsUtils();

int getUid() {
  int uid = sharedPrefsUtils.getInt('task_label_uid') ?? -1;
  uid--;
  sharedPrefsUtils.setInt('task_label_uid', uid);
  return uid;
}
