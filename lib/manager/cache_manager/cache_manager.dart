import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  late final SharedPreferences sharedPreferences;
  static final CacheManager instance = CacheManager._();
  CacheManager._();

  /// run one at main.dart
  void init(SharedPreferences sharedPreferences) async {
    this.sharedPreferences = sharedPreferences;
  }

  Future<void> clear(String tag) async {
    await sharedPreferences.remove(tag);
  }

  Map<String, dynamic>? get(String tag) {
    String? jsonAsStr = sharedPreferences.getString(tag);
    if (jsonAsStr == null) return null;
    Map<String, dynamic> json = jsonDecode(jsonAsStr);
    return json;
  }

  /// Use [CacheTag] as [tag]
  Future<void> put(String tag, Map<String, dynamic> json) async {
    String jsonAsStr = jsonEncode(json);
    await sharedPreferences.setString(tag, jsonAsStr);
  }
}
