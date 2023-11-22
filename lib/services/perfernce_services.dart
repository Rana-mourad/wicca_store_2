import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static SharedPreferences? _prefs;

  static void init() async {
    try {
      debugPrint(
          "==============================================init Preference====================================");

      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint("Failed to initialize SharedPreferences: $e");
    }
  }

  static SharedPreferences? get prefs => _prefs;
}
